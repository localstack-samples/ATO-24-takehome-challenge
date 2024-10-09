terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.31.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = "test"
  secret_key = "test"

  s3_use_path_style           = false
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}


# S3 bucket
resource "aws_s3_bucket" "site" {
  bucket        = "site"
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }
}

# Sync local directory
resource "aws_s3_object" "files" {
  for_each     = fileset(path.module, "website/**/*.{html,css,js,png}")
  bucket       = aws_s3_bucket.site.id
  key          = replace(each.value, "/^website//", "")
  source       = each.value
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)
  source_hash  = filemd5(each.value)
}

# Enable static website hosting on the bucket
resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  depends_on = [aws_s3_bucket_public_access_block.bucket_access_block]
  bucket     = aws_s3_bucket.site.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.site.id}/*"
        }
      ]
    }
  )
}

# DynamoDB table
resource "aws_dynamodb_table" "gadgets" {
  name           = "Gadgets"
  read_capacity  = 10
  write_capacity = 5

  attribute {
    name = "id"
    type = "S"
  }
  hash_key = "id"
  server_side_encryption {
    enabled = true
  }

}

# Populate DynamoDB table from the data.json file
resource "aws_dynamodb_table_item" "gadget" {
  for_each   = local.tf_data
  table_name = aws_dynamodb_table.gadgets.name
  hash_key   = "id"
  item       = jsonencode(each.value)
}


# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}


# Lambda function
resource "aws_lambda_function" "certificate-lambda" {
  function_name = "certificate-lambda"

  filename         = "./certificate-lambda/certificate-lambda.zip"
  handler          = "handler.handler"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.9"

  source_code_hash = filebase64sha256("./certificate-lambda/certificate-lambda.zip")
}
