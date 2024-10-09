import os
import requests
import json
import datetime
import boto3
import os
import uuid
import pdfrw


def handler(event, context):
    print("Hello from LocalStack Lambda container image!")

    # 1. generate certificate pdf
    generate_certificate(event["name"])

    # 2. connect to s3 on localstack
    s3_client = boto3.client(
        "s3",
        endpoint_url=f"http://{os.environ.get('LOCALSTACK_HOSTNAME')}:{os.environ.get('EDGE_PORT')}",
    )

    # 3. make sure the bucket exists
    bucket_name = "local-certification"
    if not does_bucket_exist(s3_client, bucket_name):
        print(f"Bucket '{bucket_name}' does not exist, creating it.")
        s3_client.create_bucket(Bucket=bucket_name)
    else:
        print(f"Bucket '{bucket_name}' already exists, skipping creation.")

    # 3. copy the generated file to s3
    s3_client.upload_file("/tmp/certificate.pdf", "local-certification", "certificate.pdf")

    print(f"Go back to the running services in the Status tab. Select the S3 service and find the \"local-certification\" bucket. Your LocalStack certificate will be there.")



def does_bucket_exist(s3_client, bucket_name):
    """Check if the given S3 bucket exists."""
    try:
        # Use list_buckets to check if the bucket exists in the list
        response = s3_client.list_buckets()
        for bucket in response["Buckets"]:
            if bucket["Name"] == bucket_name:
                return True
        return False
    except botocore.exceptions.ClientError as e:
        print(f"Error checking if bucket exists: {e}")
        return False


def generate_certificate(value: str):
    """Generates the highly official certificate of participation!"""
    pdf = pdfrw.PdfReader("./cert_template.pdf")
    pdf.pages[0].Annots[2].update(pdfrw.PdfDict(V=value))
    pdf.pages[0].Annots[2].update(pdfrw.PdfDict(Ff=1))
    pdf.Root.AcroForm.update(pdfrw.PdfDict(NeedAppearances=pdfrw.PdfObject("true")))
    pdfrw.PdfWriter().write("/tmp/certificate.pdf", pdf)
