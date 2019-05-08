data "template_file" "master-stream" {
  template = "${file("${path.module}/templates/master_stream.tmpl")}"

  vars = {
    api_guid = "af3e2c19-dbab-47c5-91fd-fe64f9172b46"
  }
}

data "template_file" "master-netdata" {
  template = "${file("${path.module}/templates/master_netdata.tmpl")}"
}

data "template_file" "slave-stream" {
  template = "${file("${path.module}/templates/slave_stream.tmpl")}"

  vars = {
    api_guid       = "af3e2c19-dbab-47c5-91fd-fe64f9172b46"
    master_address = "${kubernetes_deployment.netdata-master.metadata.0.labels.app}"
  }
}

data "template_file" "slave-netdata" {
  template = "${file("${path.module}/templates/slave_netdata.tmpl")}"
}

resource "kubernetes_config_map" "master-stream" {
  metadata {
    name = "master-stream-configmap"
  }

  data {
    "stream.conf" = "${data.template_file.master-stream.rendered}"
  }
}

resource "kubernetes_config_map" "master-netdata" {
  metadata {
    name = "master-netdata-configmap"
  }

  data {
    "netdata.conf" = "${data.template_file.master-netdata.rendered}"
  }
}

resource "kubernetes_config_map" "slave-stream" {
  metadata {
    name = "slave-stream-configmap"
  }

  data {
    "stream.conf" = "${data.template_file.slave-stream.rendered}"
  }
}

resource "kubernetes_config_map" "slave-netdata" {
  metadata {
    name = "slave-netdata-configmap"
  }

  data {
    "netdata.conf" = "${data.template_file.slave-netdata.rendered}"
  }
}
