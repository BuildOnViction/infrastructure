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
            name       = "master-conf"
            sub_path   = "stream.conf"
          }

          volume_mount {
            mount_path = "/host/proc"
            name       = "proc"
            read_only  = true
          }

          volume_mount {
            mount_path = "/host/sys"
            name       = "sys"
            read_only  = true
          }

          volume_mount {
            mount_path = "/var/run/docker.sock"
            name       = "docker"
            read_only  = true
          }

          security_context {
            "capabilities" = {
              "add" = ["SYS_PTRACE"]
            }
          }
        }

        volume {
          name = "master-conf"

          config_map {
            name = "master-configmap"
          }
        }

        volume {
          name = "proc"

          host_path {
            path = "/proc"
          }
        }

        volume {
          name = "sys"

          host_path {
            path = "/sys"
          }
        }

        volume {
          name = "docker"

          host_path {
            path = "/var/run/docker.sock"
          }
        }
      }
    }
  }
}
