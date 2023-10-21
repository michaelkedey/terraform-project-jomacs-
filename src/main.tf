#vpc resoure
module "vpc" {
  source = "./modules/vpc/vpc.tf"
  instance = instance.eip_instance_id

}


#instance resource
module "instance" {
    source = "./modules/ec2/ec2.tf"
    subnet_id = vpc.private_subnet
    security_grups = vpc.instance_sg
}