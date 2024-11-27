data "aws_availability_zones" "available_zones" {}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = {
    Name = "Public Subnet"
    project = var.tag
  }
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = {
    Name = "Private Subnet"
    project = var.tag
  }
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "private_subnet_cidr" {
  value = aws_subnet.private.cidr_block
}