resource "kubernetes_service_account" "helm" {
  metadata {
    name = "helm"
    namespace = "kube-system"
  }
}
