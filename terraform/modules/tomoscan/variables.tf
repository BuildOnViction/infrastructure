variable "env" {
  default = "devnet"
}

variable "scan_public_url" {
  default = "https://scan.devnet.tomochain.com"
}

variable "client_image_tag" {
  default = "latest"
}

variable "server_image_tag" {
  default = "latest"
}

variable "crawler_image_tag" {
  default = "latest"
}

variable "crawler_replicas" {
  default = 1
}

variable "master_api_url" {
  default = "http://master:3001"
}

variable "db_size" {
  default = "100Gi"
}
