
resource "kubernetes_stateful_set" "scan-db" {
  metadata {
    name = "scan-db-statefulset"

    labels {
      app = "scan-db"
    }
  }

  spec {
    replicas = 1

    service_name = "scan-db"

    selector {
      match_labels {
        app = "scan-db"
      }
    }

    template {
      metadata {
        labels {
          app = "scan-db"
        }
      }

      spec {
        container {
          image = "mongo:3.6"
          name  = "scan-db"

          volume_mount {
            name       = "scan-db-volume"
            mount_path = "/data/db"
            read_only  = false
          }
        }
      }
    }

    update_strategy {
      type = "RollingUpdate"

      rolling_update {
        partition = 1
      }
    }

    volume_claim_template {
      metadata {
        name = "scan-db-volume"
      }

      spec {
        access_modes       = ["ReadWriteOnce"]
        storage_class_name = "do-block-storage"

        resources {
          requests {
            storage = "${var.db_size}"
          }
        }
      }
    }
  }
}
