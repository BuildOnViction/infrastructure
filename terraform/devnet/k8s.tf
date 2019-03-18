resource "digitalocean_kubernetes_cluster" "devnet" {
  name    = "${var.region}-k8s-devnet"
  region  = "${var.region}"
  version = "1.13.3-do.0"

  node_pool {
    name       = "workers"
    size       = "s-6vcpu-16gb"
    node_count = 4
  }
}
