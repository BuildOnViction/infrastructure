resource "kubernetes_daemonset" "netdata-slave" {
  metadata {
    name = "netdata-slave-daemonset"

    labels {
      app = "netdata-slave"
    }
  }

  spec {
    selector {
      match_labels {
        app = "netdata-slave"
      }
    }

    template {
      metadata {
        labels {
          app = "netdata-slave"
        }
      }

      spec {
        container {
          image = "netdata/netdata"
          name  = "netdata-slave"
        }
      }
    }
  }
}
