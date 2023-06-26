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
access_key          = "ASIA25IOHIQZFSZ5EHCH"
secret_key          = "SCNNE2ewhb+up8+BbgyGxs2VItXqPEtITP1HrD+w"
token               = "FwoGZXIvYXdzEPD//////////wEaDAJygmNPiOTRcJZrLiK2AUEPeNjWn3R6pbOk01VPhG5O/hnojiYG6GXnZVZAOb9tqRMom+Hkpb1hM3ZYlgFKeSAKitkiWkIwe34yby2IGI4vPsUZaixUMf9uxCnaVivAIaF7XyNfAjToNt35s/QXzCzgGl09CGQWW43r6qd90kLgoRiRBCDXlUbYxt97mUh7f858h1lODCG93twhh3c3N/ALc1L+v1W0IKsa3L6HNJ2TkPMSUNsVXALRkhnafslgJWk8wBTgKNS45qQGMi3i2RByqqfME1/tNZR1feeLaStI2ak5X6Oo5MWReYTpb025a6Zh9SD89ccroNA=="
#git_ssh_private_key = "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"
