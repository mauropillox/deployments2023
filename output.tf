# Outputs
output "vpc_id" {
  value = aws_vpc.vpc_obligatorio.id
}

output "public_subnet_id" {
  value = aws_subnet.obligatorio_public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.obligatorio_private_subnet.id
}

output "private_subnet_2_id" {
  value = aws_subnet.obligatorio_private_subnet_2.id
}

output "ssh_sg_id" {
  value = aws_security_group.ssh_sg.id
}

output "http_sg_id" {
  value = aws_security_group.http_sg.id
}

output "public_subnet_cidr2" {
  description = "CIDR block for the additional public subnet"
  value       = aws_subnet.obligatorio_public_subnet2.cidr_block
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "frontend_ip" {
  value = aws_instance.obligatorio_frontend.public_ip
}

output "frontend_instance_id" {
  value = aws_instance.obligatorio_frontend.id
}

output "database_instance_id" {
  value = aws_db_instance.obligatorio_database.id
}

output "target_group_attachment_id" {
  value = aws_lb_target_group_attachment.obligatorio_frontend.id
}

output "s3_bucket_url" {
  value = "http://${aws_s3_bucket.obligatorio_bucket1.bucket}.s3-website-${var.region}.amazonaws.com"
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateway[*].id
}

output "nat_gateway_eip_ids" {
  value = aws_eip.nat_gateway_eip[*].id
}