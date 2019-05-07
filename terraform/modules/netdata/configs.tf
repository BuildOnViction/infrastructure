data "template_file" "master-stream" {
  template = "${file("${path.module}/templates/master_stream.tmpl")}"

  vars = {
    api_guid = "af3e2c19-dbab-47c5-91fd-fe64f9172b46"
  }
}

data "template_file" "slave-stream" {
  template = "${file("${path.module}/templates/slave_stream.tmpl")}"

  vars = {
    api_guid       = "af3e2c19-dbab-47c5-91fd-fe64f9172b46"
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
