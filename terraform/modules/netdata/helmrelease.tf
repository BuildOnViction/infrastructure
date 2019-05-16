resource "helm_release" "netdata" {
  name  = "netdata"
  chart = "${path.module}/charts/netdata"

  set {
    name  = "service.type"
    value = "${var.service_type}"
  }

  set {
    name  = "master.database.storageclass"
    value = "${var.storage_class}"
  }

  set {
    name  = "master.alarms.storageclass"
    value = "${var.storage_class}"
  }

  set {
    name  = "master.alarms.volumesize"
    value = "1Gi"
  }
}
