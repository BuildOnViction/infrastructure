resource "helm_release" "netdata" {
    name       = "netdata"
    chart      = "${path.module}/charts/netdata"

    set {
        name  = "service.type"
        value = "LoadBalancer"
    }

    set {
        name  = "master.database.storageclass"
        value = "do-block-storage"
    }

    set {
        name  = "master.alarms.storageclass"
        value = "do-block-storage"
    }

    set {
        name  = "master.alarms.volumesize"
        value = "1Gi"
    }

    depends_on = [ "kubernetes_service_account.helm" ]
}