variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "The vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "project_name" {
  type        = string
  description = "Name used for tagging"

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "The project_name value must not be empty or contain only whitespace."
  }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDRs"

  validation {
    condition = (
      length(var.public_subnet_cidrs) > 0 &&
      alltrue([
        for cidr in var.public_subnet_cidrs :
        can(cidrhost(cidr, 0))
      ])
    )

    error_message = "public_subnet_cidrs must contain at least one valid IPv4 CIDR block."
  }
}
