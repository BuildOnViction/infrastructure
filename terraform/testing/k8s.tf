resource "digitalocean_kubernetes_cluster" "testing" {
  name    = "${var.region}-k8s-testing"
  region  = "${var.region}"
  version = "1.13.3-do.0"

  node_pool {
    name       = "workers"
    size       = "s-4vcpu-8gb"
    node_count = 3
  }
}
