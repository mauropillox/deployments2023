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
access_key          = "ASIA25IOHIQZLVVFSPFH"
secret_key          = "B5SVvbM5QjPAuJ3w2jjboXuXQC3ba95UMIS07EPQ"
token               = "FwoGZXIvYXdzENj//////////wEaDLzxsjQ/m+gg2mt5kSK2AYUNyh8389Nhc74jyjZHxYMZKTTwzdacWqeBTzquYBdxXsCUuEb6ybkNMgwy8LgvtrcOWJ19/m+hvYPlz4YKKdu/b40SjV1IyjEzWayc/PjrAHQZjCJ/DzpMaG7kc4POsLvu+Ixgo//A4HNDV5zl7gHfCRKHVtNb7EKmyx4BGiW17DU/baWt/zTLvTG/I0z92HoHbtxPZ/ZxRYJI9795rifFai0NkGxJXtc95Zrav4+8795bz8KaKN2i4aQGMi3vF+poNYNcDFWG7QBOTjylezd8MwqCSbSIrW8ItQT4PWaI1Mnd+xBpKzD7tE8="
git_ssh_private_key = "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"
