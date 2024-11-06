resource "kubernetes_deployment" "flask_deployment" {
  metadata {
    name      = "flask-deployment"
    namespace = "default"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "flask"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask"
        }
      }

      spec {
        container {
          name  = "flask-container"
          image = "your-docker-image:latest" # Replace with your actual Docker image

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}