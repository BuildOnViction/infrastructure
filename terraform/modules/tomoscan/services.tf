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
