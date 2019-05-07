provider "digitalocean" {
  token = "${var.do_token}"
}

provider "kubernetes" {
  host = "${digitalocean_kubernetes_cluster.devnet.endpoint}"

  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.devnet.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.devnet.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.devnet.kube_config.0.cluster_ca_certificate)}"
}

module "netdata" {
  source = "../modules/netdata"
}

# module "tomomaster" {
#   source = "../modules/tomomaster"
# }

module "tomoscan" {
  source = "../modules/tomoscan"

  crawler_replicas = 2
}
