variable "project_name" {
  type        = string
  description = "Project name"

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "The project_name value must not be empty or contain only whitespace."
  }
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"

  validation {
    condition     = can(regex("^vpc-[0-9a-f]+$", var.vpc_id))
    error_message = "The provided vpc_id must follow the expected AWS VPC ID format."
  }
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"

  validation {
    condition     = can(regex("^subnet-[0-9a-f]+$", var.subnet_id))
    error_message = "The provided subnet_id must follow the expected AWS Subnet ID format."
  }
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"

  validation {
    condition     = length(trimspace(var.instance_type)) > 0
    error_message = "The instance_type value must not be empty or contain only whitespace."
  }
}

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

  validation {
    condition     = can(cidrhost(var.ssh_allowed_cidr, 0))
    error_message = "The ssh_allowed_cidr value must be a valid IPv4 CIDR block."
  }
}

variable "http_allowed_cidr" {
  type        = string
  description = "CIDR block allowed to access EC2 through HTTP"

  validation {
    condition     = can(cidrhost(var.http_allowed_cidr, 0))
    error_message = "The http_allowed_cidr value must be a valid IPv4 CIDR block."
  }
}
