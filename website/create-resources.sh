awslocal s3api create-bucket --bucket clue2
awslocal s3 sync ./ s3://clue2
awslocal s3 website s3://clue2/ --index-document index.html
