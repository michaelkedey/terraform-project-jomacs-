output "subents" {
  value = {
    pub_sn1 = aws_subnet.project_public_subnet.id, 
    pub_sn2 = aws_subnet.project_public_subnet_2.id, 
    prv_sn = aws_subnet.project_private_subnet.id
  }
}

output "vpc" {
  value = aws_vpc.project_vpc.id
}

output "load_balancer" {
  value = aws_lb.project_lb.dns_name
}

output "instance_sg" {
  value = aws_security_group.project_instance_sg.id
}