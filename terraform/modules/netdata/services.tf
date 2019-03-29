resource "kubernetes_service" "netdata" {
  metadata {
    name = "netdata-service"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.netdata-server.metadata.0.labels.app}"
    }

    port {
      port        = 80
      target_port = 19999
    }

    type = "LoadBalancer"
  }
}
