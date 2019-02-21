# resource "digitalocean_droplet" "stats" {
#   count = "${var.droplet_count}"
#   image = "${var.image}"
#   name = "${var.region}-${var.env}-droplet-${var.name}-${count.index}"
#   region = "${var.region}"
#   size = "${var.size}"
#   ssh_keys = "${var.keys}"
#   private_networking = "${var.private_networking}"
#   resize_disk = "${var.resize_disk}"
# }
