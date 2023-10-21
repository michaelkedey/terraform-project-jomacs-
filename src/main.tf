provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source          = "./modules/ec2"
  subnet_id       = module.vpc.pr_sn
  security_groups = [module.vpc.instance_sg]
}
