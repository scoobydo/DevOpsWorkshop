resource "kubernetes_service" "flask_service" {
  metadata {
    name      = "flask-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = kubernetes_deployment.flask_deployment.metadata[0].name
    }

    port {
      port     = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}