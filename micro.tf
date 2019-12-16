provider "aws" {
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
region = "sa-east-1"
}
resource "aws_instance" "terraform" {
ami = "ami-00138b07206d4ceaf"
instance_type = "t2.micro"
key_name = "928f9f6274114cbfb31e59f2139de568-key"
}
variable "instance_count" {
  default = "2"
}
output "ips" {
  value = ["${aws_instance.terraform.*.public_ip}"]
}
