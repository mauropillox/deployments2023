resource "aws_instance" "obligatorio_frontend" {
  ami           = "ami-03ededff12e34e59e"
  instance_type = var.frontend_instance_type

  key_name = var.key_name

  tags = {
    Name        = "instance-frontend"
    obligatorio = "True"
  }

  vpc_security_group_ids = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]

  subnet_id = aws_subnet.obligatorio_public_subnet.id

  depends_on = [
    aws_eks_cluster.obligatorio_cluster,
    aws_eks_node_group.obligatorio_node_group
  ] # Update the dependency with the correct resource name

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }

    inline = [
      "echo 'Instalando AWS CLI 2.12:'",
      "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "unzip awscliv2.zip",
      "sudo ./aws/install",
      "echo 'Instalando cliente de Kubernetes'",
      "curl -LO 'https://dl.k8s.io/release/stable.txt'",
      "K8S_VERSION=$(cat stable.txt)",
      "curl -LO \"https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl\"",
      "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
      "echo 'La versión del cliente de Kubernetes es:'",
      "sudo -u ec2-user /usr/local/bin/kubectl version --client",
      "echo 'Configurando AWS CLI'",
      "sudo -u ec2-user mkdir -p ~/.aws",
      "aws configure set aws_access_key_id ${var.access_key} --profile default",
      "aws configure set aws_secret_access_key ${var.secret_key} --profile default",
      "aws configure set aws_session_token ${var.token} --profile default",
      "aws configure set region ${var.region} --profile default",
      "aws configure list > /tmp/aws_configure_output",
      "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name} --profile default",
      "kubectl get nodes",
      "echo 'Kubeconfig actualizado para el clúster ${var.cluster_name}'",
      "sudo cat /tmp/aws_configure_output",
      "sudo yum install git -y",
      "git init",
      "git config --global init.defaultBranch main",
      "git clone https://github.com/mauropillox/deployments2023",
      "ls -ltr",
      "kubectl get pods",
      "cd /home/ec2-user/deployments2023/redis/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/adservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/shippingservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/cartservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/currencyservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/emailservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/paymentservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/productcatalogservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/recommendationservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/checkoutservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/loadgenerator/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "cd /home/ec2-user/deployments2023/frontend/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "kubectl get pods",
      "kubectl get deployments",
      "kubectl get services",
      "sleep 60",
      "kubectl get pods",
      "kubectl get deployments",
      "kubectl get services",
      # ""
      # ""
      # ""
      # ""
      # ""
    ]
  }
}