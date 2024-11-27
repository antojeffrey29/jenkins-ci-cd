# Outputs from the network module
output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}

# Outputs from the compute module
output "jump_server_ip" {
  value = module.compute.jump_server_id
}

output "app_server_id" {
  value = module.compute.app_server_id
}

output "rds_instance_id" {
  value = module.compute.rds_instance_id
}

# Outputs from the security module
output "lambda_role_arn" {
  value = module.security.lambda_role_arn
}

# Outputs from the others module
output "sns_topic_arn" {
  value = module.others.sns_topic_arn
}

output "sqs_queue_url" {
  value = module.others.sqs_queue_url
}

output "website_url" {
  value = module.others.website_url
}