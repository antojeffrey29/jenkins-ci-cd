resource "aws_security_group" "jump_server_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Update this to restrict access in production
  }
  tags = {
    project = var.tag
  }
}

output "jump_server_sg" {
  value = aws_security_group.jump_server_sg.id
}

resource "aws_security_group" "app_server_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Update this to restrict access in production
  }

  ingress {
    from_port   = 3306  # Allow MySQL access from the app server to RDS
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.db_sg.id]
  }

  tags = {
    project = var.tag
  }
}

output "app_server_sg" {
  value = aws_security_group.app_server_sg.id
}

resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.private_cidr_blocks # Allow access from the private subnet
  }

  tags = {
    project = var.tag
  }
}

output "db_sg" {
  value = aws_security_group.db_sg.id
}