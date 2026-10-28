variable "vpc_cidr" {}
variable "project_name" {}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "instance_type" {
}
