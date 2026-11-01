variable "aws_region" {
  type        = string
  description = "AWS region where infrastructure will be deployed"
}

variable "vpc_cidr" {}

variable "project_name" {}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "instance_type" {}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR block allowed to access EC2 through SSH"
}

variable "http_allowed_cidr" {
  type        = string
  description = "CIDR block allowed to access EC2 through HTTP"
}
