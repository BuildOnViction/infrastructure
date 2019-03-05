resource "kubernetes_deployment" "stats" {
  metadata {
    name = "stats-deployment-test"
    labels {
      app = "stats"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "stats-deployment-test"
      }
    }

    template {
      metadata {
        labels {
          app = "stats-deployment-test"
        }
      }

      spec {
        container {
          image = "nginx"
          name  = "nging-test"
        }
      }
    }
  }
}

resource "kubernetes_service" "stats" {
  metadata {
    name = "stats-service-test"
  }
  spec {
    selector {
      app = "${kubernetes_deployment.stats.metadata.0.labels.app}"
    }
    port {
      port = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
