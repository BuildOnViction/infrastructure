variable "service_type" {
  default     = "LoadBalancer"
  description = "Kubernetes service type for the main netdata service"
}

variable "storage_class" {
  default     = "do-block-storage"
  description = "Kubernetes storage class used for netdata storage"
}
