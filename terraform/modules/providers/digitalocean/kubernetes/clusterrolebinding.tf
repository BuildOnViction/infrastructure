resource "kubernetes_cluster_role_binding" "helm" {
    metadata {
        name = "helm"
    }
    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind = "ClusterRole"
        name = "cluster-admin"
    }
    subject {
        kind = "ServiceAccount"
        name = "helm"
        namespace = "kube-system"
    }
}
