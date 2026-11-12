variable "aws_profile" {
  type        = string
  description = "AWS CLI profile used for authentication"
  default     = "terraform-sso"
}

variable "aws_region" {
  type        = string
  description = "AWS region where infrastructure will be deployed"
}

variable "project_name" {}

variable "vpc_cidr" {}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "instance_type" {}

variable "key_name" {
  type        = string
  description = "Name of the existing AWS EC2 key pair"

  validation {
    condition     = length(trimspace(var.key_name)) > 0
    error_message = "The key_name value must not be empty or contain only whitespace."
  }
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR block allowed to access EC2 through SSH"
}

variable "http_allowed_cidr" {
  type        = string
  description = "CIDR block allowed to access EC2 through HTTP"
}
