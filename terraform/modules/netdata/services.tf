resource "kubernetes_service" "master-db" {
  metadata {
    name = "netdata-master"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.netdata-master.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 19999
      target_port = 19999
    }
  }
}

resource "kubernetes_service" "netdata" {
  metadata {
    name = "netdata-service"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.netdata-master.metadata.0.labels.app}"
    }

    port {
      port        = 80
      target_port = 19999
    }

    type = "LoadBalancer"
  }
}
