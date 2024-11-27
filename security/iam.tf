resource "aws_iam_role" "lambda_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
  tags = {
    project = var.tag
  }
}

resource "aws_iam_role" "lambda_role1" {
  name = "lambda_exec_role1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
  tags = {
    project = var.tag
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "rds:DescribeDBInstances",
          "rds-db:connect",
          "sns:Publish",
          "logs:*"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy1" {
  role = aws_iam_role.lambda_role1.id
  policy = jsonencode({
    "Version": "2012-10-17",  
  "Statement": [  
   {  
    "Sid": "AllowRDSAccess",  
    "Effect": "Allow",  
    "Action": [  
      "rds:DescribeDBInstances",  
      "rds:ExecuteSql"  
    ],  
    "Resource": "*"  #replace with specific resource arn
   },  
   {  
    "Sid": "AllowDynamoDBAccess",  
    "Effect": "Allow",  
    "Action": [  
      "dynamodb:PutItem"  
    ],  
    "Resource": "*"  #replace with specific resource arn
   },  
   {  
    "Sid": "AllowSESAccess",  
    "Effect": "Allow",  
    "Action": [  
      "ses:SendEmail"  
    ],  
    "Resource": "*"  #replace with specific resource arn
   }  
  ]
  })
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "lambda_role_arn1" {
  value = aws_iam_role.lambda_role1.arn
}

# Define the IAM policy
resource "aws_iam_policy" "s3_bucket_policy_permissions" {
  name        = "S3BucketPolicyPermissions"
  description = "Policy to allow updating bucket policies and public access block settings"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:PutBucketPolicy",
          "s3:PutBucketPublicAccessBlock",
          "s3:GetBucketPolicy",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::my-static-website-s7yzwcai",
          "arn:aws:s3:::my-static-website-s7yzwcai/*"
        ]
      }
    ]
  })
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "attach_policy_to_user" {
  user       = "antojeffrey29"
  policy_arn = aws_iam_policy.s3_bucket_policy_permissions.arn
}