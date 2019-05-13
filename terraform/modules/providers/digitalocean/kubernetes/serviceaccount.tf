resource "kubernetes_service_account" "admin" {
  metadata {
    name      = "admin"
    namespace = "kube-system"
  }
}
