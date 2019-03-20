provider "aws" {
 region = "us-east-1"
}

resource "aws_instance" "table1-mc-ansible-int" {
 ami = "ami-0565af6e282977273"
 instance_type = "t2.medium"
 key_name = "miguel-class-key"
 tags = { 
  Name = "table1mc_inst_ansible-integration"
 }
 provisioner "remote-exec" {
   inline = ["sudo apt-get -y install python"]
   connection {
     type = "ssh"
     user = "ubuntu"
     private_key = "${file("/home/ubuntu/miguel-class-key")}"
   }
  }
}
