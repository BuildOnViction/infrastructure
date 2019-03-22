resource "kubernetes_stateful_set" "master-db" {
  metadata {
    name = "master-db-statefulset"

    labels {
      app = "master-db"
    }
  }

  spec {
    replicas = 1

    service_name = "master-db"

    selector {
      match_labels {
        app = "master-db"
      }
    }

    template {
      metadata {
        labels {
          app = "master-db"
        }
      }

      spec {
        container {
          image = "mongo:3.6"
          name  = "master-db"

          volume_mount {
            name       = "master-db-volume"
            mount_path = "/data/db"
            read_only  = false
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "master-db-volume"
      }

      spec {
        access_modes       = ["ReadWriteOnce"]
        storage_class_name = "do-block-storage"

        resources {
          requests {
            storage = "${var.volume_db_size}"
          }
        }
      }
    }
  }
}
