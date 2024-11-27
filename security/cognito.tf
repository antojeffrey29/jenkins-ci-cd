resource "aws_cognito_user_pool" "user_pool" {
  name = "user_pool"
  tags = {
    project = var.tag
  }
}

output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}