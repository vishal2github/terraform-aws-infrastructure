variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "project_name" {
  type        = string
  description = "Name used for tagging"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDRs"
}
