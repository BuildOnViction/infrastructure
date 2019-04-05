data "template_file" "master-stream" {
  template = "${file("${path.module}/templates/master_stream.tmpl")}"
  vars = {
    api_guid = 10
  }
}

resource "kubernetes_config_map" "master-stream" {
  metadata {
    name = "master-stream-configmap"
  }

  data {
    config = "${data.template_file.master-stream.rendered}"
  }
}
