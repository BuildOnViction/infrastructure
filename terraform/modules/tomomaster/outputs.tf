output "loadbalancer_ip" {
  value = kubernetes_service.master.load_balancer_ip
}
