output "public_subnet1" {
  value = module.vpc.pb_sn1
}

output "public_subnet2" {
  value = module.vpc.pb_sn2
}

output "private_subnet" {
  value = module.vpc.pr_sn
}

output "vpc" {
  value = module.vpc.vpc
}

output "load_balancer" {
  value = module.vpc.load_balancer
}
