provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source      = "./modules/vpc"
  instance_id = module.ec2.instance_id
}

module "ec2" {
  source          = "./modules/ec2"
  subnet_id       = module.vpc.pr_sn
  security_groups = [module.vpc.instance_sg]
}
