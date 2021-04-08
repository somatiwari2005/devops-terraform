provider "aws" {
access_key = var.access_key
secret_key = var.secret_key
region = "sa-east-1"
}

resource "aws_instance" "terraform"{
count = "2"
ami = var.ami
instance_type = "t2.micro"
subnet_id              = aws_subnet.subnet.id
associate_public_ip_address = true
vpc_security_group_ids = [aws_security_group.aws-sg.id]
key_name = var.ssh_key
}
output "ip" {
    value = join(",", aws_instance.terraform.*.public_ip)
}
