# Resource for the VPC
resource "aws_vpc" "vpc_obligatorio" {
  cidr_block = var.vpc_cidr

  tags = {
    Name      = "obligatorio-vpc"
    terraform = "True"
  }
}

# Resource for the public subnet
resource "aws_subnet" "obligatorio_public_subnet" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.vpc_aws_az
  map_public_ip_on_launch = true

  tags = {
    Name      = "obligatorio-public-subnet"
    terraform = "True"
  }
}

# Resource for the additional public subnet
resource "aws_subnet" "obligatorio_public_subnet2" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = var.public_subnet_cidr2
  availability_zone       = var.vpc_aws_az2
  map_public_ip_on_launch = true

  tags = {
    Name      = "obligatorio-public-subnet2"
    terraform = "True"
  }
}

# Resource for the first private subnet
resource "aws_subnet" "obligatorio_private_subnet" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.vpc_aws_az
  map_public_ip_on_launch = true # Enable auto-assign public IP for the private subnet

  tags = {
    Name      = "obligatorio-private-subnet"
    terraform = "True"
  }
}

# Resource for the second private subnet
resource "aws_subnet" "obligatorio_private_subnet_2" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = var.private_subnet_cidr_2
  availability_zone       = var.vpc_aws_az_2
  map_public_ip_on_launch = true # Enable auto-assign public IP for the private subnet

  tags = {
    Name      = "obligatorio-private-subnet-2"
    terraform = "True"
  }
}

# Resource for creating a route table for the VPC
resource "aws_route_table" "obligatorio_route_table" {
  vpc_id = aws_vpc.vpc_obligatorio.id

  tags = {
    Name      = "obligatorio-route-table"
    terraform = "True"
  }
}

# Resource for attaching Internet Gateway to VPC
resource "aws_internet_gateway" "obligatorio_igw" {
  vpc_id = aws_vpc.vpc_obligatorio.id

  tags = {
    Name      = "obligatorioc1-internet-gateway"
    terraform = "True"
  }
}

# Resource for creating a route for the public subnet
resource "aws_route" "obligatorio_public_subnet_route" {
  route_table_id         = aws_route_table.obligatorio_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.obligatorio_igw.id
}

# Resource for associating the route table with the public subnet
resource "aws_route_table_association" "obligatorio_public_subnet_association" {
  subnet_id      = aws_subnet.obligatorio_public_subnet.id
  route_table_id = aws_route_table.obligatorio_route_table.id
}

# Resource for the private subnet
resource "aws_route_table_association" "obligatorio_private_subnet_association" {
  subnet_id      = aws_subnet.obligatorio_private_subnet.id
  route_table_id = aws_route_table.obligatorio_route_table.id
}

# Resource for creating a route for the private subnet
resource "aws_route" "obligatorio_private_subnet_route" {
  route_table_id         = aws_route_table.obligatorio_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Resource for NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.obligatorio_public_subnet.id

  tags = {
    Name      = "nat-gateway"
    terraform = "True"
  }
}

# Resource for Elastic IP for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  vpc = true
  lifecycle {
    prevent_destroy = true
  }
}
