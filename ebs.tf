resource "aws_ebs_volume" "obligatorio_volume" {
  availability_zone = var.vpc_aws_az
  size              = var.ebs_volume_size
  tags = {
    Name        = "obligatorio"
    Environment = "production"
  }
}
