provider "acme" {
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = "${tls_private_key.private_key.private_key_pem}"
  email_address   = "${var.cloudflare_email}"
}

resource "acme_certificate" "certificate" {
  account_key_pem = "${acme_registration.reg.account_key_pem}"
  common_name     = "${var.fqdn}"

  dns_challenge {
    provider           = "cloudflare"

    config {
      CLOUDFLARE_EMAIL   = "${var.cloudflare_email}"
      CLOUDFLARE_API_KEY = "${var.cloudflare_api_key}"  
    }
  }
}
