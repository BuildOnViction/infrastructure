output "loadbalancer_ip" {
  value = "${kubernetes_service.scan.load_balancer_ingress.0.ip}"
}
