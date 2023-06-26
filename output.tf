# Outputs (Salidas)

# ID de la VPC
output "vpc_id" {
  value = aws_vpc.vpc_obligatorio.id
}

# ID de la subred pública
output "public_subnet_id" {
  value = aws_subnet.obligatorio_public_subnet.id
}

# ID de la subred privada
output "private_subnet_id" {
  value = aws_subnet.obligatorio_private_subnet.id
}

# ID de la segunda subred privada
output "private_subnet_2_id" {
  value = aws_subnet.obligatorio_private_subnet_2.id
}

# ID del grupo de seguridad SSH
output "ssh_sg_id" {
  value = aws_security_group.ssh_sg.id
}

# ID del grupo de seguridad HTTP
output "http_sg_id" {
  value = aws_security_group.http_sg.id
}

# Bloque CIDR para la subred pública adicional
output "public_subnet_cidr2" {
  description = "Bloque CIDR para la subred pública adicional"
  value       = aws_subnet.obligatorio_public_subnet2.cidr_block
}

# ID del grupo de seguridad de la base de datos
output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

# IP pública del frontend
output "frontend_ip" {
  value = aws_instance.obligatorio_frontend.public_ip
}

# ID de la instancia del frontend
output "frontend_instance_id" {
  value = aws_instance.obligatorio_frontend.id
}

# ID de la instancia de la base de datos
output "database_instance_id" {
  value = aws_db_instance.obligatorio_database.id
}

# ID del adjunto del grupo de destino (target group)
output "target_group_attachment_id" {
  value = aws_lb_target_group_attachment.obligatorio_frontend.id
}

# URL del bucket de S3
output "s3_bucket_url" {
  value = "http://${aws_s3_bucket.obligatorio_bucket1.bucket}.s3-website-${var.region}.amazonaws.com"
}

# IDs de los NAT Gateways
output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateway[*].id
}

# IDs de las Elastic IPs para los NAT Gateways
output "nat_gateway_eip_ids" {
  value = aws_eip.nat_gateway_eip[*].id
}

# output "kubernetes_server" {
#   value = filesha256("output.tf")
# }

output "kubernetes_server" {
  value = aws_instance.obligatorio_frontend.public_ip
}
