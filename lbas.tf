# Recurso para el balanceador de carga
resource "aws_lb" "obligatorio" {
  name               = "obligatorio-lb"
  load_balancer_type = "application"
  subnets = [
    aws_subnet.obligatorio_public_subnet.id,
    aws_subnet.obligatorio_public_subnet2.id
  ]

  security_groups = [
    aws_security_group.http_sg.id,
    aws_security_group.ssh_sg.id
  ]

  tags = {
    Name      = "obligatorio-lb"
    terraform = "True"
  }

  # depends_on = [
  #   aws_lb_target_group_attachment.obligatorio_frontend
  # ]
}


# Recurso para el launch template
resource "aws_launch_template" "obligatorio" {
  name          = "obligatorio-launch-template"
  image_id      = "ami-03ededff12e34e59e" # Replace with the appropriate AMI
  instance_type = "t2.micro"              # Replace with the appropriate instance type

  # Rest of the configuration for the launch template...
}


# Recurso para el grupo de objetivos
resource "aws_lb_target_group" "obligatorio" {
  name     = "obligatorio-target-group" # Replace with the appropriate name
  port     = 80                         # Replace with the appropriate port
  protocol = "HTTP"                     # Replace with the appropriate protocol
  vpc_id   = aws_vpc.vpc_obligatorio.id # Replace with the appropriate VPC ID

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

# Asociar el grupo de objetivos con las instancias
resource "aws_lb_target_group_attachment" "obligatorio_frontend" {
  target_group_arn = aws_lb_target_group.obligatorio.arn
  target_id        = aws_instance.obligatorio_frontend.id
}

# Recurso para el grupo de autoscaling
resource "aws_autoscaling_group" "obligatorio" {
  name             = "obligatorio-autoscaling"
  min_size         = 1
  max_size         = 5
  desired_capacity = 2

  launch_template {
    id      = aws_launch_template.obligatorio.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.obligatorio.arn]

  vpc_zone_identifier = [
    aws_subnet.obligatorio_public_subnet.id,
    aws_subnet.obligatorio_public_subnet2.id
  ]

  depends_on = [
    aws_lb_target_group_attachment.obligatorio_frontend
  ]
}
