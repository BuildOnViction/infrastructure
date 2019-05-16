resource "digitalocean_certificate" "cert" {
  name             = "${var.name}"
  private_key      = "${acme_certificate.certificate.private_key_pem}"
  leaf_certificate = "${acme_certificate.certificate.certificate_pem}"
}
