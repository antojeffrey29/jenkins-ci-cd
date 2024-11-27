#s3_bucket_
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "my-static-website-${random_string.bucket_suffix.result}"
  depends_on = [ random_string.bucket_suffix ]
  //acl = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags = {
    project = var.tag
  }
}

# Update the public access block settings
resource "aws_s3_bucket_public_access_block" "my_static_website_block" {
  bucket                  = aws_s3_bucket.static_website_bucket.bucket
  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.static_website_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static_website_bucket.bucket
  key    = "index.html"
  source = "${path.module}/../src/index.html"
  //acl    = "public-read"
  tags = {
    project = var.tag
  }
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.static_website_bucket.bucket
  key    = "error.html"
  source = "${path.module}/../src/error.html"
  //acl    = "public-read"
  tags = {
    project = var.tag
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  upper = false
  special = false
}

output "website_url" {
  value       = aws_s3_bucket.static_website_bucket.website_endpoint
  description = "The URL of the S3 bucket static website"
}

output "s3_bucket_id" {
  value = aws_s3_bucket.static_website_bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.static_website_bucket.arn
}