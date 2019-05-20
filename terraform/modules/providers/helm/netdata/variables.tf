variable "service_type" {
  default     = "LoadBalancer"
  description = "Kubernetes service type for the main netdata service"
}

variable "storage_class" {
  default     = "do-block-storage"
  description = "Kubernetes storage class used for netdata storage"
}

variable "notifications_url" {
  default     = ""
  description = "Slack webhook url for sending health notifications"
}

variable "notifications_recipient" {
  default     = ""
  description = "Slack recipient channel for sending health notifications"
}
