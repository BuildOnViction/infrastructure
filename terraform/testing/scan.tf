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
            name  = "WS_SECRET"
            value = "test"
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
            value = "mongodb://scan-mongo:27017/explorer"
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
            value = "https://master.devnet.tomochain.com"
          }

          env {
            name  = "BASE_URL"
            value = "https://scan.devnet.tomochain.com"
          }

          env {
            name  = "JWT_SECRET"
            value = "123456"
          }

          env {
            name  = "APP_SECRET_FILE"
            value = "123456"
          }

          env {
            name  = "SENDGRID_API_KEY_FILE"
            value = "123456"
          }

          env {
            name  = "RE_CAPTCHA_SECRET_FILE"
            value = "123456"
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

resource "kubernetes_deployment" "scan-mongo" {
  metadata {
    name = "scan-mongo-deployment"

    labels {
      app = "scan-mongo"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "scan-mongo"
      }
    }

    template {
      metadata {
        labels {
          app = "scan-mongo"
        }
      }

      spec {
        container {
          image = "mongo:3.6"
          name  = "scan-mongo"
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

resource "kubernetes_service" "scan" {
  metadata {
    name = "scan-client-service"
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
