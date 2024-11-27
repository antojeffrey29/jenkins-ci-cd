variable "s3_bucket_id" {
  
}

variable "s3_bucket_arn" {
  
}

variable "tag" {
  
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_cidr_blocks" {
  description = "Private cidr blocks"
  type        = list(string)
}