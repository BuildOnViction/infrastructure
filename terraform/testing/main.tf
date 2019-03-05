provider "digitalocean" {
  token = "${var.do_token}"
}

provider "kubernetes" {
  host = "${digitalocean_kubernetes_cluster.testing.endpoint}"

  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.testing.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.testing.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.testing.kube_config.0.cluster_ca_certificate)}"
}
