resource "kubernetes_deployment" "netdata-master" {
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

          volume_mount {
            mount_path = "/etc/netdata/stream.conf"
            name       = "master-stream-conf"
            sub_path   = "stream.conf"
          }

          volume_mount {
            mount_path = "/etc/netdata/netdata.conf"
            name       = "master-netdata-conf"
            sub_path   = "netdata.conf"
          }
        }

        volume {
          name = "master-stream-conf"

          config_map {
            name = "master-stream-configmap"
          }
        }

        volume {
          name = "master-netdata-conf"

          config_map {
            name = "master-netdata-configmap"
          }
        }
      }
    }
  }
}
