variable "aws_region" {
  description = "AWS Region"
  type        = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default = "10.0.2.0/24"
}

variable "jump_server_ami" {
  type = string
  default = "ami-063d43db0594b521b"
}

variable "app_server_ami" {
  type = string
  default = "ami-063d43db0594b521b"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "tag" {
  default = "demo-project"
}