data "aws_availability_zones" "available_zones" {}

resource "aws_instance" "jump_server" {
  ami           = var.jump_server_ami 
  instance_type = var.instance_type           
  subnet_id     = var.public_subnet_id
  tags = {
    Name = "JumpServer"
    project = var.tag
  }

  vpc_security_group_ids = [var.jump_server_sg]
}

output "jump_server_id" {
  value = aws_instance.jump_server.id
}

resource "aws_instance" "app_server" {
  ami           = var.app_server_ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  tags = {
    Name = "AppServer"
    project = var.tag
  }

  vpc_security_group_ids = [var.app_server_sg]
}

output "app_server_id" {
  value = aws_instance.app_server.id
}