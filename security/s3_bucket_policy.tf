resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.s3_bucket_id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "${var.s3_bucket_arn}/*"
      }
    ]
  })
}