provider "digitalocean" {
  token = "${var.do_token}"
}

provider "kubernetes" {
  host = "${module.kubernetes.endpoint}"

  client_certificate     = "${module.kubernetes.client_certificate}"
  client_key             = "${module.kubernetes.client_key}"
  cluster_ca_certificate = "${module.kubernetes.cluster_ca_certificate}"
}

provider "helm" {
  kubernetes {
    host = "${module.kubernetes.endpoint}"

    client_certificate     = "${module.kubernetes.client_certificate}"
    client_key             = "${module.kubernetes.client_key}"
    cluster_ca_certificate = "${module.kubernetes.cluster_ca_certificate}"
  }
}

module "kubernetes" {
  source = "../modules/providers/digitalocean/kubernetes"

  name = "devnet"
}

# module "tomomaster" {
#   source = "../modules/tomomaster"
# }

module "tomoscan" {
  source = "../modules/tomoscan"

  crawler_replicas = 2
}
