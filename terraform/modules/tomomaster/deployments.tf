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
          image = "tomochain/tomomaster:${var.deployment_master_image_tag}"
          name  = "master"

          env {
            name  = "TOMOSCAN_API_URL"
            value = "${var.scan_api_url}"
          }

          env {
            name  = "NODE_ENV"
            value = "${var.env}"
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
    replicas = "${var.crawler_replicas}"

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
          image = "tomochain/tomomaster:${var.deployment_master-crawler_image_tag}"
          name  = "master-crawler"
          args  = ["run", "crawl"]

          env {
            name  = "NODE_ENV"
            value = "${var.env}_crawler"
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
