data "template_file" "master-stream" {
  template = "${file("${path.module}/templates/master_stream.tmpl")}"

  vars = {
    api_guid = 10
  }
}

data "template_file" "slave-stream" {
  template = "${file("${path.module}/templates/master_stream.tmpl")}"

  vars = {
    api_guid       = 10
    master_address = "${kubernetes_deployment.netdata-master.metadata.0.labels.app}:1999"
  }
}

resource "kubernetes_config_map" "master" {
  metadata {
    name = "master-configmap"
  }

  data {
    "stream.conf" = "${data.template_file.master-stream.rendered}"
  }
}

resource "kubernetes_config_map" "slave" {
  metadata {
    name = "slave-configmap"
  }

  data {
    "stream.conf" = "${data.template_file.slave-stream.rendered}"
  }
}
