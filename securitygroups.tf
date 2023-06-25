# Resource for the SSH security group
resource "aws_security_group" "ssh_sg" {
  name        = "grupo-seguridad-ssh"
  description = "Security group for SSH traffic"
  vpc_id      = aws_vpc.vpc_obligatorio.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "grupo-seguridad-ssh"
    terraform = "True"
  }
}

# Resource for the HTTP security group
resource "aws_security_group" "http_sg" {
  name        = "grupo-seguridad-http"
  description = "Security group for HTTP traffic"
  vpc_id      = aws_vpc.vpc_obligatorio.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "grupo-seguridad-http"
    terraform = "True"
  }
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS cluster"

  vpc_id = aws_vpc.vpc_obligatorio.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Resource for the DB security group
resource "aws_security_group" "db_sg" {
  name        = "grupo-seguridad-db"
  description = "Security group for RDSzsdatabase"
  vpc_id      = aws_vpc.vpc_obligatorio.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.http_sg.id]
  }

  tags = {
    Name      = "grupo-seguridad-db"
    terraform = "True"
  }
}

# Crea un grupo de seguridad para Redis
resource "aws_security_group" "redis_sg" {
  name        = "obligatorio-redis-sg"
  description = "Security group for Redis"
  vpc_id      = aws_vpc.vpc_obligatorio.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group para permitir acceso HTTP al bucket de S3
resource "aws_security_group" "s3_access_sg" {
  name        = "grupo-seguridad-s3-access"
  description = "Security group for S3 bucket access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "grupo-seguridad-s3-access"
    terraform = "True"
  }
}
