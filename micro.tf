provider "aws" {
access_key = var.access_key
secret_key = var.secret_key
region = "sa-east-1"
}
data "aws_availability_zones" "available" {} # List of availability zones in a given region
# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.network_address_space
  enable_dns_hostnames = "true"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet" {
  cidr_block              = var.subnet_address_space
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta-subnet" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rtb.id
}

# SECURITY GROUPS #

resource "aws_security_group" "aws-sg" {
  name   = "mysecuritygroup"
  vpc_id = aws_vpc.vpc.id

  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace the IP with the machine IP where terraform is running
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace the IP with the machine IP where terraform is running
  }

  # Outbound Rules
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
