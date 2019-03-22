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
