provider "aws" {
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
region = "sa-east-1"
}
resource "aws_instance" "terraform"{
count = '2'
ami = "ami-00023c695a5493524"
instance_type = "t2.micro"
key_name = "928f9f6274114cbfb31e59f2139de568-key"
}
tags = {
    Name  = "Terraform-${count.index + 1}"
}
output "ip" {
    value = "${join(",", aws_instance.web.*.public_ip)}"
}
