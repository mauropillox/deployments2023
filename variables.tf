variable "key_name" {
  description = "Name of the SSH key pair to associate with the EC2 instances"
  type        = string
  default     = "vockey" # Replace with the appropriate key pair name
}

variable "frontend_instance_type" {
  description = "EC2 instance type for the frontend server"
  type        = string
  default     = "t2.micro" # Replace with the appropriate instance type
}

variable "stock_control_instance_type" {
  description = "EC2 instance type for the stock control server"
  type        = string
  default     = "t2.micro" # Replace with the appropriate instance type
}

variable "shopping_cart_instance_type" {
  description = "EC2 instance type for the shopping cart server"
  type        = string
  default     = "t2.micro" # Replace with the appropriate instance type
}

variable "product_catalog_instance_type" {
  description = "EC2 instance type for the product catalog server"
  type        = string
  default     = "t2.micro" # Replace with the appropriate instance type
}

variable "database_engine" {
  description = "Database engine for the RDS instance"
  type        = string
  default     = "mysql" # Replace with the appropriate database engine
}

variable "database_instance_class" {
  description = "Database instance class for the RDS instance"
  type        = string
  default     = "db.t2.micro" # Replace with the appropriate instance class
}

variable "database_allocated_storage" {
  description = "Allocated storage for the RDS instance (in GB)"
  type        = number
  default     = 10 # Replace with the appropriate allocated storage
}

variable "database_master_password" {
  description = "Master password for the RDS instance"
  type        = string
  default     = "obligatorio" # Replace with the appropriate master password
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16" # Replace with the appropriate VPC CIDR block
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "vpc_aws_az" {
  description = "Availability Zone for the VPC"
  type        = string
}

variable "vpc_aws_az_2" {
  description = "Availability Zone for the second private subnet"
  type        = string
}

variable "private_key_path" {
  description = "Availability Zone for the second private subnet"
  type        = string
  default     = "./labsuser.pem"
}

variable "cluster_name" {
  type    = string
  default = "obligatorio-cluster"
}

variable "node_group_name" {
  type    = string
  default = "obligatorio-node-group"
}

variable "eks_version" {
  description = "Version of EKS"
  type        = string
  default     = "1.27"
}

variable "access_key" {
  description = "AWS access key"
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}

variable "token" {
  description = "AWS session token"
  type        = string
  default     = ""
}


variable "profile" {
  description = "AWS profile"
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "public_subnet_cidr2" {
  description = "CIDR block for the additional public subnet"
  type        = string
  default     = "10.0.4.0/24" # Replace with the appropriate default value
}

variable "vpc_aws_az2" {
  description = "Availability zone for the additional public subnet"
  type        = string
  default     = "us-east-1b" # Replace with the appropriate default value
}

variable "git_ssh_private_key" {
  description = "SSH private key for Git authentication"
  type        = string
}

variable "nat_gateway_eip_allocation_ids" {
  description = "Allocation IDs of the Elastic IPs for NAT Gateways"
  type        = list(string)
  default     = []
}