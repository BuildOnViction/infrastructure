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
            mount_path = "/etc/netdata/stream.conf"
            name       = "slave-conf"
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
          name = "slave-conf"

          config_map {
            name = "slave-configmap"
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
