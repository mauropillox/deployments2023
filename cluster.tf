data "aws_iam_role" "labrole-arn" {
  name = "LabRole"
}

# resource "aws_eks_cluster" "obligatorio_cluster" {
#   name     = "obligatorio-cluster"
#   role_arn = data.aws_iam_role.labrole-arn.arn

#   vpc_config {
#     subnet_ids = [
#       aws_subnet.obligatorio_public_subnet.id,
#       aws_subnet.obligatorio_public_subnet2.id
#     ]
#   }
# }

resource "aws_eks_cluster" "obligatorio_cluster" {
  name     = "obligatorio-cluster"
  role_arn = data.aws_iam_role.labrole-arn.arn

  vpc_config {
    subnet_ids         = [
      aws_subnet.obligatorio_private_subnet.id,
      aws_subnet.obligatorio_private_subnet_2.id
    ]
    endpoint_public_access = true
    endpoint_private_access = false
    public_access_cidrs = ["0.0.0.0/0"]
  }
}


resource "aws_eks_node_group" "obligatorio_node_group" {
  cluster_name    = aws_eks_cluster.obligatorio_cluster.name
  node_group_name = "obligatorio-node-group"
  node_role_arn   = data.aws_iam_role.labrole-arn.arn
  subnet_ids      = [
    aws_subnet.obligatorio_public_subnet.id,
    aws_subnet.obligatorio_public_subnet2.id
  ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = "nodo 1-obligatorio"
  }
}
