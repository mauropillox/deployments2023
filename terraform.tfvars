# Key Pair
key_name         = "vockey"
private_key_path = "./labsuser.pem"

# Instance Types
frontend_instance_type        = "t2.micro" # Replace with the appropriate instance type for the frontend server
stock_control_instance_type   = "t2.micro" # Replace with the appropriate instance type for the stock control server
shopping_cart_instance_type   = "t2.micro" # Replace with the appropriate instance type for the shopping cart server
product_catalog_instance_type = "t2.micro" # Replace with the appropriate instance type for the product catalog server
ebs_volume_size = 100


# Database Configuration
database_engine            = "mysql"       # Replace with the appropriate database engine
database_instance_class    = "db.t2.micro" # Replace with the appropriate instance class
database_allocated_storage = 10            # Replace with the appropriate allocated storage for the RDS instance
database_master_password   = "obligatorio" # Replace with the appropriate master password

# VPC Configuration
vpc_cidr              = "10.0.0.0/16" # Replace with the appropriate VPC CIDR block
public_subnet_cidr    = "10.0.1.0/24" # Replace with the appropriate public subnet CIDR block
private_subnet_cidr   = "10.0.2.0/24" # Replace with the appropriate private subnet CIDR block
private_subnet_cidr_2 = "10.0.3.0/24" # Replace with the appropriate second private subnet CIDR block
public_subnet_cidr2   = "10.0.4.0/24"
vpc_aws_az            = "us-east-1a" # Replace with the appropriate Availability Zone for the VPC
vpc_aws_az_2          = "us-east-1b" # Replace with the appropriate Availability Zone for the second private subnet

# Cluster configuration
cluster_name    = "obligatorio-cluster"
node_group_name = "obligatorio-node-group"
eks_version     = "1.27"
# kubernetes_server = "http://${aws_instance.obligatorio_frontend.public_ip}"


# Security configuration
# profile    = "[default]"
region              = "us-east-1"
access_key          = "ASIA25IOHIQZHWYOERI3"
secret_key          = "rcr6pVXLkdB2+AqdHGLdK9AYdDsVBaCkcFILfyc8"
token               = "FwoGZXIvYXdzEOD//////////wEaDC3OVaf1vMoe1PQgqyK2AZs13WQMxpNSfF7QdY+4DOTn2QVNqEz57a8MkNlIRuOc6+tfB4wZGgek4t8vtr6vF5ReYI9NVzPwj3DuL3mcG7foO88dtLZoK5kFsoSvVlT3d7ElipKM3WDe+15doR3AQnD61PFLpe1tF9BjklRtZDUR6CQ9X/W9EuKprBrhMEfbH6o3OCqZxsYPMIhtD70ioRVHsX48ca1OeQhKF61NuXj+nKcbsIW7C3arOf/FTn7XYwdOhhTLKN6J46QGMi1gViM7vhO2qSHiJHKzHirVHQQkaUr/HN6oR4u9uieZsQPCKkBLN4M2wAAthDE="
git_ssh_private_key = "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"
