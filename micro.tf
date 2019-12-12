provider "aws" {
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
region = "us-east-2"
}
resource "aws_instance" "terraform" {
ami = "ami-0d03add87774b12c5"
instance_type = "t2.micro"
}
