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
region     = "us-east-1"
access_key = "ASIA25IOHIQZI62WXUEG"
secret_key = "kY9TaQO9DeT5Z/vljhizt5jYsvq2vtkL/b3bbpv0"
token      = "FwoGZXIvYXdzEMP//////////wEaDJONtUcfrhlckheRgyK2AU+UhK+boHOoIzs3oOWDDYCgUcSIDQLu1At4GyTJ+jvR5Txhj2RlFOoXltkcETpDq/8vASF7ti8lr5FxyA/yz+asDVr7CpkCG8+dOFVAB0OQxsbEj03Dtx2uRc8br1igWulYDosE8ucJ6YXfskvtU33nJ+d02kXBuNl8I7vtCSDXJu40lJDFm1u5uhqwSKdLwReCcuSa0X05WuiLczcM0Y+RsfINzi432iPoChd7s5HsOT5YfCqgKOfJ3KQGMi13nqhjjdPSeLt9iBj2Hq3p2sqmesrZRNQES9AKYN/lj9TCPfpwGEWaj6zL06s="
git_ssh_private_key = "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"
