provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = var.vpc_cidr
  project_name        = var.project_name
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "ec2" {
  source = "../../modules/ec2"

  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_ids[0]
  vpc_id            = module.vpc.vpc_id
  project_name      = var.project_name
  ssh_allowed_cidr  = var.ssh_allowed_cidr
  http_allowed_cidr = var.http_allowed_cidr
}
