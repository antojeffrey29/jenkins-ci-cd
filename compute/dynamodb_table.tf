# Create a DynamoDB table  
resource "aws_dynamodb_table" "emp" {
  name           = "employee_table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "emp_mail"  # Primary key attribute
  range_key      = "emp_name"  # Sort key (if needed)

  attribute {
    name = "emp_mail"
    type = "S"
  }

  attribute {
    name = "emp_name"
    type = "S"
  }

  attribute {
    name = "salary"
    type = "N"
  }

  global_secondary_index {
    name               = "emp_name_index"
    hash_key           = "emp_name"  
    projection_type    = "ALL"  
  }

  global_secondary_index {
    name               = "salary_index"
    hash_key           = "salary"  
    projection_type    = "ALL"
  }

  tags = {
    project = var.tag
  }
}