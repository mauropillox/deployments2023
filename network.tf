# Recurso para la VPC
resource "aws_vpc" "vpc_obligatorio" {
  cidr_block = var.vpc_cidr

  tags = {
    Name      = "obligatorio-vpc"
    terraform = "True"
  }
}

# Recurso para la subred pública
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

# Recurso para una subred pública adicional
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

# Recurso para la primera subred privada
resource "aws_subnet" "obligatorio_private_subnet" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.vpc_aws_az
  map_public_ip_on_launch = true # Habilitar la asignación automática de IP pública para la subred privada

  tags = {
    Name      = "obligatorio-private-subnet"
    terraform = "True"
  }
}

# Recurso para la segunda subred privada
resource "aws_subnet" "obligatorio_private_subnet_2" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = var.private_subnet_cidr_2
  availability_zone       = var.vpc_aws_az_2
  map_public_ip_on_launch = true # Habilitar la asignación automática de IP pública para la subred privada

  tags = {
    Name      = "obligatorio-private-subnet-2"
    terraform = "True"
  }
}

# Recurso para crear una tabla de enrutamiento para la VPC
resource "aws_route_table" "obligatorio_route_table" {
  vpc_id = aws_vpc.vpc_obligatorio.id

  tags = {
    Name      = "obligatorio-route-table"
    terraform = "True"
  }
}

# Recurso para adjuntar la puerta de enlace de Internet a la VPC
resource "aws_internet_gateway" "obligatorio_igw" {
  vpc_id = aws_vpc.vpc_obligatorio.id

  tags = {
    Name      = "obligatorioc1-internet-gateway"
    terraform = "True"
  }
}

# Recurso para crear una ruta para la subred pública
resource "aws_route" "obligatorio_public_subnet_route" {
  route_table_id         = aws_route_table.obligatorio_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.obligatorio_igw.id
}

# Recurso para asociar la tabla de enrutamiento con la subred pública
resource "aws_route_table_association" "obligatorio_public_subnet_association" {
  subnet_id      = aws_subnet.obligatorio_public_subnet.id
  route_table_id = aws_route_table.obligatorio_route_table.id
}

# Recurso para asociar la tabla de enrutamiento con la subred privada
resource "aws_route_table_association" "obligatorio_private_subnet_association" {
  subnet_id      = aws_subnet.obligatorio_private_subnet.id
  route_table_id = aws_route_table.obligatorio_route_table.id
}

# Recurso para crear una ruta para la subred privada
resource "aws_route" "obligatorio_private_subnet_route" {
  route_table_id         = aws_route_table.obligatorio_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Recurso para el Gateway NAT
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.obligatorio_public_subnet.id

  tags = {
    Name      = "nat-gateway"
    terraform = "True"
  }
}

# Recurso para la IP elástica del Gateway NAT
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  lifecycle {
    prevent_destroy = false
  }
}
