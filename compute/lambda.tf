#Lambda functions code
data "archive_file" "notify_admin" {
  type = "zip"
  source_file = "${path.module}/../src/notify_admin.py"
  output_path = "lambda_function_src1.zip"
}

data "archive_file" "load_data" {
  type = "zip"
  source_file = "${path.module}/../src/load_data.py"
  output_path = "lambda_function_src2.zip"
}

#Lambda functions
resource "aws_lambda_function" "notify_admin" {
  filename = "lambda_function_src1.zip"
  function_name = "notifyAdmin"
  handler = "lambda_handler"
  runtime = "python3.10" 
  role    = var.lambda_role_arn1
  source_code_hash = data.archive_file.notify_admin.output_base64sha256
  environment {
    variables = {
      RDS_HOST       = aws_db_instance.app_db.address
      RDS_USER       = "admin"
      RDS_PASSWORD   = "password"
      RDS_DATABASE   = "mydb"
      SNS_TOPIC_ARN  = var.SNS_TOPIC_ARN
    }
  }
  tags = {
    project = var.tag
  }
}
 
resource "aws_lambda_function" "load_data" {
  filename = "lambda_function_src2.zip"
  function_name = "loadData"
  handler = "lambda_handler"
  runtime = "python3.10"
  role    = var.lambda_role_arn
  source_code_hash = data.archive_file.load_data.output_base64sha256
  environment {
    variables = {
      RDS_ENDPOINT        = ""
      RDS_DB_NAME         = ""
      RDS_USERNAME        = ""
      RDS_PASSWORD        = ""
      DYNAMODB_TABLE_NAME = ""
    }
  }
  tags = {
    project = var.tag
  }
}

output "notify_admin" {
  value = aws_lambda_function.notify_admin.function_name
}

output "notify_admin_arn" {
  value = aws_lambda_function.notify_admin.arn
}