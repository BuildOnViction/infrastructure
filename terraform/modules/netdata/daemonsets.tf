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

          volume_mount {
            mount_path = "/etc/netdata/"
            name       = "slave-conf"
          }
        }

        volume {
          name = "slave-conf"

          config_map {
            name = "slave-configmap"
          }
        }
      }
    }
  }
}
