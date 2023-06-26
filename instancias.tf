resource "aws_instance" "obligatorio_instancia" {
  ami           = "ami-03ededff12e34e59e"
  instance_type = var.frontend_instance_type

  key_name = var.key_name

  tags = {
    Name        = "obligatorio-instancia"
    obligatorio = "True"
  }

  vpc_security_group_ids = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]

  # subnet_id = aws_subnet.obligatorio_public_subnet.id
  subnet_id = aws_subnet.obligatorio_private_subnet.id

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
      # "echo 'Configurando SSH para Git'",
      # "sudo -u ec2-user mkdir -p ~/.ssh",
      # "echo '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' | sudo tee ~/.ssh/id_rsa",
      # "sudo chmod 600 ~/.ssh/id_rsa",
      # "sudo eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa",
      # "sudo -u ec2-user touch ~/.ssh/config",
      # "echo 'Host github.com\n\tStrictHostKeyChecking no' | sudo tee -a ~/.ssh/config",
      # "echo 'Configurando Git'",
      # "git config --global init.defaultBranch main",
      # "git config --global user.name 'Mauro'",
      # "git config --global user.email 'mauro.guimarans96@gmail.com'",
      # "git clone https://github.com/mauropillox/deployments2023",
      "git init",
      "git clone https://github.com/mauropillox/deployments2023",
      "git config --global init.defaultBranch main",
      "ls -ltr",
      "sleep 10",
      "sudo yum install docker -y",
      "sudo yum install jq -y",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo systemctl status docker",
      "sudo usermod -aG docker ec2-user",
      "sudo -u ec2-user docker login --username=mauropillox --password='cloud2023'",
      "kubectl delete deployments --all",
      "kubectl delete services --all",
      "cd /home/ec2-user/deployments2023/redis/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/adservice/",
      # "sudo -u ec2-user docker build -t mauropillox/adserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/adserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/adservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/shippingservice/",
      # "sudo -u ec2-user docker build -t mauropillox/shippingserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/shippingserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/shippingservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/cartservice/",
      # "sudo -u ec2-user docker build -t mauropillox/cartserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/cartserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/cartservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      #"cd /home/ec2-user/deployments2023/currencyservice/",
      # "sudo -u ec2-user docker build -t mauropillox/currencyserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/currencyserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/currencyservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/emailservice/",
      # "sudo -u ec2-user docker build -t mauropillox/emailserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/emailserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/emailservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/paymentservice/",
      # "sudo -u ec2-user docker build -t mauropillox/paymentserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/paymentserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/paymentservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/productcatalogservice/",
      # "sudo -u ec2-user docker build -t mauropillox/productcatalogserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/productcatalogserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/productcatalogservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      #"cd /home/ec2-user/deployments2023/recommendationservice/",
      # "sudo -u ec2-user docker build -t mauropillox/recommendationserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/recommendationserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/recommendationservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/checkoutservice/",
      # "sudo -u ec2-user docker build -t mauropillox/checkoutserviceobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/checkoutserviceobligatorio:latest",
      "cd /home/ec2-user/deployments2023/checkoutservice/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/loadgenerator/",
      # "sudo -u ec2-user docker build -t mauropillox/loadgeneratorobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/paymentserviceobligatorio:latest",
      # "cd /home/ec2-user/deployments2023/loadgenerator/deployment",
      # "kubectl apply -f kubernetes-manifests.yaml",
      # "cd /home/ec2-user/deployments2023/frontend/",
      # "sudo -u ec2-user docker build -t mauropillox/frontendobligatorio:latest .",
      # "sudo -u ec2-user docker push mauropillox/frontendobligatorio:latest",
      "cd /home/ec2-user/deployments2023/frontend/deployment",
      "kubectl apply -f kubernetes-manifests.yaml",
      "sleep 15",
      "kubectl get pods",
      "kubectl get deployments",
      "kubectl get services",
      "server=$(kubectl config view -o json | jq -r '.clusters[].cluster.server')",
      "echo \"kubernetes_server = \\\"$server\\\"\" > server.tf",
      "sleep 15",
      "kubectl get pods",
      "kubectl get deployments",
      "kubectl get services",
      # "sudo docker rmi $(docker images -q)",
      # "sudo docker rm -f $(docker ps -aq)",
      # "sudo docker rmi $(docker images -q)",
      "sleep 20",
    ]
  }
}

resource "aws_volume_attachment" "obligatorio_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.obligatorio_volume.id
  instance_id = aws_instance.obligatorio_instancia.id
}

# resource "null_resource" "read_kubernetes_server" {
#   # This resource has no configuration block
#   # It will be used to read the contents of the file in the provisioner

#   provisioner "local-exec" {
#     command = "cat /tmp/kubernetes_server.txt"
#   }
# }

