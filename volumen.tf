# Definir el recurso de PersistentVolume
resource "kubernetes_persistent_volume" "obligatorio_pv" {
  metadata {
    name = "obligatorio-pv"
  }

  spec {
    capacity = {
      storage = "5Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name = "default"

    persistent_volume_source {
      host_path {
        path = "/var/www/html"
      }
    }
  }
}

# Definir el recurso de PersistentVolumeClaim
resource "kubernetes_persistent_volume_claim" "obligatorio_pvc" {
  metadata {
    name = "obligatorio-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "2Gi"
      }
    }
    storage_class_name = "default"
    volume_name        = kubernetes_persistent_volume.obligatorio_pv.metadata[0].name
  }
}

# Utilizar el PVC en el despliegue
resource "kubernetes_deployment" "obligatorio_despliegue" {
  metadata {
    name = "obligatorio-despliegue"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "obligatorio-aplicacion"
      }
    }

    template {
      metadata {
        labels = {
          app = "obligatorio-aplicacion"
        }
      }

      spec {
        container {
          name  = "obligatorio-contenedor"
          image = "mi-imagen"
          
          volume_mount {
            name       = "obligatorio-volumen-montado"
            mount_path = "/var/www/html"
          }
        }
      }
    }
  }
}
