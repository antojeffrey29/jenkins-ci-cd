resource "aws_db_instance" "app_db" {
  identifier         = "mydb"
  engine             = "mysql"
  instance_class     = "db.t3.micro"       # Free tier eligible instance type
  allocated_storage   = 20
  username           = "admin"
  password           = "password"
  db_name            = "mydb"
  skip_final_snapshot = true
  multi_az = false
  vpc_security_group_ids = [var.db_sg]
  db_subnet_group_name  = aws_db_subnet_group.default.name
  tags = {
    project = var.tag
  }
}


resource "aws_subnet" "backend" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  tags = {
    Name = "Backend Subnet"
    project = var.tag
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "my_db_subnet_group"  # Unique name for the subnet group
  subnet_ids = [var.private_subnet_id,aws_subnet.backend.id]
  tags = {
    Name = "My DB Subnet Group"
    project = var.tag
  }
}

output "rds_instance_id" {
  value = aws_db_instance.app_db.id
}