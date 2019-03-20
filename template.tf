data "template_file" "dev_hosts" {
  template = "${file("dev_hosts.cfg")}"
  depends_on = [
    "aws_instance.table1-mc-ansible-int"
  ]
  vars {
    api_public = "${aws_instance.table1-mc-ansible-int.public_ip}"
    host = "host01"
  }
}

resource "null_resource" "dev-hosts" {
  triggers {
    template_rendered = "${data.template_file.dev_hosts.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.dev_hosts.rendered}' > inventory/hosts"
  }
}
