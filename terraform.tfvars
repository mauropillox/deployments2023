# Key Pair
key_name         = "vockey"
private_key_path = "./labsuser.pem"

# Instance Types
frontend_instance_type        = "t2.micro" # Replace with the appropriate instance type for the frontend server
stock_control_instance_type   = "t2.micro" # Replace with the appropriate instance type for the stock control server
shopping_cart_instance_type   = "t2.micro" # Replace with the appropriate instance type for the shopping cart server
product_catalog_instance_type = "t2.micro" # Replace with the appropriate instance type for the product catalog server

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

# Security configuration
# profile    = "[default]"
region              = "us-east-1"
access_key          = "ASIA25IOHIQZI7X2LBM5"
secret_key          = "J+XeTB35m5UedI+QxJ93xXlJQ79pXqz5PxxFnvJC"
token               = "FwoGZXIvYXdzENz//////////wEaDOGJHQfoVMzzDcWTNyK2AeA8peXRfYlNk5VYRnVbdvROltVoKlLtVwV4yudSouPYnvyMsVCLJ0XNb+SqIexS4O94UVq4ZKeUMXstRXMyJo6a41iKlB1pKksB+ytCwMUmSsZcTg4HIaclHOaOeNTOY2sXxXOcAKACoGnRGBuS6J8tnjOhj9cnPTjMzyMUcKE0jwngEr5nm69huKqcARa4QD7hpJASV7kbeUrWlBzqibD8OdvWLoYomIli3uddlJ8BieLW9lD4KMCT4qQGMi2FzdO+eZJy6WCHsjb3pTczyj72KGIYHMTxV0icmjXA2T6cu4SHvU77+ksFmZA="
git_ssh_private_key = "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"
