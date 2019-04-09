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
            mount_path = "/etc/netdata/"
            name       = "master-conf"
          }
        }

        volume {
          name = "master-conf"

          config_map {
            name = "master-configmap"
          }
        }
      }
    }
  }
}
