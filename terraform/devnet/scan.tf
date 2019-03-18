resource "kubernetes_deployment" "scan-client" {
  metadata {
    name = "scan-client-deployment"

    labels {
      app = "scan-client"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "scan-client"
      }
    }

    template {
      metadata {
        labels {
          app = "scan-client"
        }
      }

      spec {
        container {
          image = "tomochain/tomoscan-client"
          name  = "scan-client"

          env {
            name  = "API_URL"
            value = "http://scan-server:3333"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "scan-server" {
  metadata {
    name = "scan-server-deployment"

    labels {
      app = "scan-server"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "scan-server"
      }
    }

    template {
      metadata {
        labels {
          app = "scan-server"
        }
      }

      spec {
        container {
          image = "tomochain/tomoscan-server"
          name  = "scan-server"

          env {
            name  = "MONGODB_URI"
            value = "mongodb://scan-db:27017/explorer"
          }

          env {
            name  = "REDIS_HOST"
            value = "scan-redis"
          }

          env {
            name  = "CLIENT_URL"
            value = "https://scan.devnet.tomochain.com/"
          }

          env {
            name  = "TOMOMASTER_API_URL"
            value = "http://tomomaster:3001"
          }

          env {
            name  = "BASE_URL"
            value = "https://scan.devnet.tomochain.com"
          }

          env {
            name  = "JWT_SECRET"
            value = "TODO"
          }

          env {
            name  = "APP_SECRET"
            value = "TODO"
          }

          env {
            name  = "SENDGRID_API_KEY"
            value = "TODO"
          }

          env {
            name  = "RE_CAPTCHA_SECRET"
            value = "TODO"
          }

          env {
            name  = "NODE_ENV"
            value = "devnet"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "scan-server" {
  metadata {
    name = "scan-server"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.scan-server.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 3333
      target_port = 3333
    }
  }
}

resource "kubernetes_deployment" "scan-crawler" {
  metadata {
    name = "scan-crawler-deployment"

    labels {
      app = "scan-crawler"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels {
        app = "scan-crawler"
      }
    }

    template {
      metadata {
        labels {
          app = "scan-crawler"
        }
      }

      spec {
        container {
          image   = "tomochain/tomoscan-server"
          name    = "scan-crawler"
          args = ["run", "crawl"]

          env {
            name  = "MONGODB_URI"
            value = "mongodb://scan-db:27017/explorer"
          }

          env {
            name  = "REDIS_HOST"
            value = "scan-redis"
          }

          env {
            name  = "NODE_ENV"
            value = "devnet"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "scan-redis" {
  metadata {
    name = "scan-redis-deployment"

    labels {
      app = "scan-redis"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "scan-redis"
      }
    }

    template {
      metadata {
        labels {
          app = "scan-redis"
        }
      }

      spec {
        container {
          image = "redis:4-alpine"
          name  = "scan-redis"
        }
      }
    }
  }
}

resource "kubernetes_service" "scan-redis" {
  metadata {
    name = "scan-redis"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.scan-redis.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 6379
      target_port = 6379
    }
  }
}

resource "kubernetes_stateful_set" "scan-db" {
  metadata {
    name = "scan-db-deployment"

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
        }
      }
    }
  }
}

resource "kubernetes_service" "scan-db" {
  metadata {
    name = "scan-db"
  }

  spec {
    selector {
      app = "${kubernetes_stateful_set.scan-db.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 27017
      target_port = 27017
    }
  }
}

resource "kubernetes_service" "scan" {
  metadata {
    name = "scan-service"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.scan-client.metadata.0.labels.app}"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
