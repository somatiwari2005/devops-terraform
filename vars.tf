variable "access_key" {}
variable "secret_key" {}
variable "ami" {
  default = "ami-00145d9bdd54f0bc2"
  }
variable "ssh_key" {
  default = "928f9f6274114cbfb31e59f2139de568-key"
  }

variable "network_address_space" {                               
     default = "10.1.0.0/16"                                                                                                                                                   default = "10.1.0.0/16"
}

variable "subnet_address_space" {                               
     default = "10.1.0.0/24"                                                                                                                                                   default = "10.1.0.0/16"
}
