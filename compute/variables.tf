variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "private_cidr_blocks" {
  description = "Private cidr blocks"
  type        = list(string)
}

variable "SNS_TOPIC_ARN" {
  description = "SNS topic arn"
  type = string
}

variable "lambda_role_arn" {
  
}

variable "lambda_role_arn1" {
  
}

variable "jump_server_ami" {
  type = string
}

variable "app_server_ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "tag" {
  
}

variable "jump_server_sg" {
  
}

variable "app_server_sg" {
  
}

variable "db_sg" {
  
}