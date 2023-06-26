# resource "kubernetes_persistent_volume" "obligatorio_pv" {
#   metadata {
#     name = "obligatorio-pv"
#   }

#  depends_on = [aws_instance.obligatorio_frontend]  # Add dependency on instancias.tf resource

#   spec {
#     capacity = {
#       storage = "5Gi"
#     }
#     access_modes                     = ["ReadWriteOnce"]
#     persistent_volume_reclaim_policy = "Retain"
#     storage_class_name               = "default"

#     persistent_volume_source {
#       host_path {
#         path = data.external.kubernetes_server.result
#       }
#     }
#   }
# }

# resource "kubernetes_deployment" "obligatorio_despliegue" {
#   metadata {
#     name = "obligatorio-despliegue"
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "obligatorio-aplicacion"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "obligatorio-aplicacion"
#         }
#       }

#       spec {
#         container {
#           name  = "obligatorio-contenedor"
#           image = "mi-imagen"

#           env {
#             name  = "SERVER"
#             value = data.external.kubernetes_server.result
#           }

#           volume_mount {
#             name       = "obligatorio-volumen-montado"
#             mount_path = "/var/www/html"
#           }
#         }
#       }
#     }
#   }
# }
