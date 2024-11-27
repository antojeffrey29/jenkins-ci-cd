# VPC Definition
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC1"
    project = var.tag
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}