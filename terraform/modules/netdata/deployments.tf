resource "kubernetes_deployment" "netdata-server" {
  metadata {
    name = "netdata-master-deployment"

    labels {
      app = "netdata-master"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "netdata-master"
      }
    }

    template {
      metadata {
        labels {
          app = "netdata-master"
        }
      }

      spec {
        container {
          image = "netdata/netdata"
          name  = "netdata-master"
        }
      }
    }
  }
}
