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
          image = "tomochain/tomoscan-client:${var.client_image_tag}"
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
          image = "tomochain/tomoscan-server:${var.server_image_tag}"
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
            value = "${var.scan_public_url}"
          }

          env {
            name  = "TOMOMASTER_API_URL"
            value = "${var.master_api_url}"
          }

          env {
            name  = "BASE_URL"
            value = "${var.scan_public_url}"
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
            value = "${var.env}"
          }
        }
      }
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
    replicas = "${var.crawler_replicas}"

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
          image = "tomochain/tomoscan-server:${var.crawler_image_tag}"
          name  = "scan-crawler"
          args  = ["run", "crawl"]

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
