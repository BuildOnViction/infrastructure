output "loadbalancer_ip" {
  value = "${kubernetes_service.netdata.load_balancer_ingress.0.ip}"
}
