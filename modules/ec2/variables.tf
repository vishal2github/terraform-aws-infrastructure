variable "vpc_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR block allowed to access EC2 through SSH"
}

variable "http_allowed_cidr" {
  type        = string
  description = "CIDR block allowed to access EC2 through HTTP"
}
