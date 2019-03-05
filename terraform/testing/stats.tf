resource "kubernetes_deployment" "stats" {
  metadata {
    name = "stats-deployment"
    labels {
      app = "stats"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "stats"
      }
    }

    template {
      metadata {
        labels {
          app = "stats"
        }
      }

      spec {
        container {
          image = "tomochain/netstats"
          name  = "stats"
          env {
            name  = "WS_SECRET"
            value = "test"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "stats" {
  metadata {
    name = "stats-service"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.stats.metadata.0.labels.app}"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
