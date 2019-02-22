resource "digitalocean_droplet" "stats" {
  count = 1
  image = "ubuntu-18-04-x64"
  name = "${var.region}-dl-testing-stats-${count.index}"
  region = "${var.region}"
  size = "s-1vcpu-1gb"
  ssh_keys = [23511610, 23778766]
  private_networking = false
  resize_disk = false
  tags = [
    "${digitalocean_tag.stats.name}",
    "${digitalocean_tag.testing.name}",
  ]
}
