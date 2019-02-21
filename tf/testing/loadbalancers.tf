resource "digitalocean_loadbalancer" "stats" {
  name = "${var.region}-lb-testing-stats-${count.index}"
  region = "${var.region}"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"
    target_port = 3000
    target_protocol = "http"
  }

  healthcheck {
    port = 3000
    protocol = "tcp"
  }

  droplet_tag = "${digitalocean_tag.stats.name}"
}
