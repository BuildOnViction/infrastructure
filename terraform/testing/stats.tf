resource "kubernetes_deployment" "stats" {
  metadata {
    name = "stats-deployment"

    labels {
      app = "stats-deployment-test"
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
          image = "tomochain/netstats"
          name  = "stats-deployment-test"
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
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
