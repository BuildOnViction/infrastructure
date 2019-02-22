resource "digitalocean_tag" "testing" {
  name = "testing"
}

resource "digitalocean_tag" "stats" {
  name = "stats"
}

resource "digitalocean_tag" "master" {
  name = "master"
}

resource "digitalocean_tag" "worker" {
  name = "worker"
}
