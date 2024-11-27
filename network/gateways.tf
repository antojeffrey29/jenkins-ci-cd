# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw"
    project = var.tag
  }
}

# NAT Gateway for Private Subnet Internet Access
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id  # Ensure you have an Elastic IP for the NAT Gateway
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "ngw"
    project = var.tag
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
  tags = {
    project = var.tag
  }
}