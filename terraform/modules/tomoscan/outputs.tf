output "loadbalancer_ip" {
  value = kubernetes_service.scan.load_balancer_ip
}
