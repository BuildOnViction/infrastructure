output "endpoint" {
  value = "${digitalocean_kubernetes_cluster.cluster.endpoint}"
}

output "client_certificate" {
  value = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)}"
}

output "client_key" {
  value = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)}"
}

output "cluster_ca_certificate" {
  value = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)}"
}

output "service_account" {
  value = "${kubernetes_service_account.admin.metadata.0.name}"
}
