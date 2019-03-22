
variable "env" {
  default = "devnet"
}
variable "deployment_master_image_tag" {
  default = "latest"
}
variable "deployment_master-crawler_image_tag" {
  default = "latest"
}
variable "crawler_replicas" {
  default = 1
}
variable "scan_api_url" {
  default = "http://scan-server:3333"
}
variable "volume_db_size" {
  default = "100Gi"
}
