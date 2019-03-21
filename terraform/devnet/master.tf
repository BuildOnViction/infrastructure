resource "kubernetes_deployment" "master" {
  metadata {
    name = "master-deployment"

    labels {
      app = "master"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "master"
      }
    }

    template {
      metadata {
        labels {
          app = "master"
        }
      }

      spec {
        container {
          image = "tomochain/tomomaster:latest"
          name  = "master"

          env {
            name  = "TOMOSCAN_API_URL"
            value = "http://scan-server:3333"
          }

          env {
            name  = "NODE_ENV"
            value = "devnet"
          }

          env {
            name  = "DB_URI"
            value = "mongodb://master-db:27017/governance"
          }

          env {
            name  = "REDIS_HOST"
            value = "scan-redis"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "master-crawler" {
  metadata {
    name = "master-crawler-deployment"

    labels {
      app = "master-crawler"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "master-crawler"
      }
    }

    template {
      metadata {
        labels {
          app = "master-crawler"
        }
      }

      spec {
        container {
          image = "tomochain/tomomaster:latest"
          name  = "master-crawler"
          args  = ["run", "crawl"]

          env {
            name  = "NODE_ENV"
            value = "devnet_crawler"
          }

          env {
            name  = "DB_URI"
            value = "mongodb://master-db:27017/governance"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "master-redis" {
  metadata {
    name = "master-redis-deployment"

    labels {
      app = "master-redis"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "master-redis"
      }
    }

    template {
      metadata {
        labels {
          app = "master-redis"
        }
      }

      spec {
        container {
          image = "redis:4-alpine"
          name  = "master-redis"
        }
      }
    }
  }
}

resource "kubernetes_service" "master-redis" {
  metadata {
    name = "master-redis"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.master-redis.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 6379
      target_port = 6379
    }
  }
}

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
            storage = "100Gi"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "master-db" {
  metadata {
    name = "master-db"
  }

  spec {
    selector {
      app = "${kubernetes_stateful_set.master-db.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 27017
      target_port = 27017
    }
  }
}

resource "kubernetes_service" "master" {
  metadata {
    name = "master-service"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.master.metadata.0.labels.app}"
    }

    port {
      port        = 80
      target_port = 3001
    }

    type = "LoadBalancer"
  }
}
