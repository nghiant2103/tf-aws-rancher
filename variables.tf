variable "project_name" {
  default = "rancher-k8s"
}

variable "environment" {
  default = "dev"
}

variable "region" {
  default = "us-east-1"
}

variable "availability_zone_1" {
  default = "us-east-1a"
}

variable "availability_zone_2" {
  default = "us-east-1b"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_01_cidr_block" {
  default = "10.0.1.0/24"
}

variable "private_subnet_01_cidr_block" {
  default = "10.0.2.0/24"
}

variable "private_subnet_02_cidr_block" {
  default = "10.0.3.0/24"
}

variable "allow_cidr_block_ssh" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "web_traffic_ports" {
  type    = list(number)
  default = [80, 443, 8080, 8443]
}

variable "allow_cidr_block_web_traffic" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

