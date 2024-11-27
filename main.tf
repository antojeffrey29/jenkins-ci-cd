terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "tfstatebuc"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./network"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  tag = var.tag
}

module "compute" {
  source              = "./compute"
  vpc_id              = module.network.vpc_id
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_id   = module.network.private_subnet_id
  private_cidr_blocks = [module.network.private_subnet_cidr]
  SNS_TOPIC_ARN       = module.others.sns_topic_arn
  lambda_role_arn = module.security.lambda_role_arn
  lambda_role_arn1 = module.security.lambda_role_arn1
  jump_server_sg = module.security.jump_server_sg
  app_server_sg = module.security.app_server_sg
  db_sg = module.security.db_sg
  jump_server_ami = var.jump_server_ami
  app_server_ami = var.app_server_ami
  instance_type = var.instance_type
  tag = var.tag
}

module "security" {
  source        = "./security"
  s3_bucket_id  = module.others.s3_bucket_id
  s3_bucket_arn = module.others.s3_bucket_arn
  vpc_id              = module.network.vpc_id
  private_cidr_blocks = [module.network.private_subnet_cidr]
  tag = var.tag
}

module "others" {
  source           = "./others"
  notify_admin     = module.compute.notify_admin
  notify_admin_arn = module.compute.notify_admin_arn
  tag = var.tag
}