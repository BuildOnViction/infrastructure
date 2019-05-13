resource "kubernetes_cluster_role_binding" "admin" {
  metadata {
    name = "admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "admin"
    namespace = "kube-system"
  }
}
