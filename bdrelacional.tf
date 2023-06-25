# Recurso para la base de datos relacional
resource "aws_db_subnet_group" "obligatorio_db_subnet_group" {
  name        = "obligatorio-db-subnet-group"
  description = "DB subnet group for AC1 project"

  subnet_ids = [
    aws_subnet.obligatorio_private_subnet.id,
    aws_subnet.obligatorio_private_subnet_2.id
  ]
}

# Recurso para la base de datos relacional
resource "aws_db_instance" "obligatorio_database" {
  engine              = var.database_engine
  instance_class      = var.database_instance_class
  allocated_storage   = var.database_allocated_storage
  identifier          = "obligatorio-database"       # Replace with the appropriate database identifier
  username            = "obligatorio"                # Replace with the appropriate username
  password            = var.database_master_password # Replace with the appropriate master password
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  db_subnet_group_name = aws_db_subnet_group.obligatorio_db_subnet_group.name

  tags = {
    Name      = "obligatorio-database"
    terraform = "True"
  }

  # Specify the availability zone (AZ) for the RDS instance
  availability_zone = var.vpc_aws_az
}