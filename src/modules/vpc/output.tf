output "pb_sn1" {
  value = aws_subnet.project_public_subnet.id
}

output "pb_sn2" {
  value = aws_subnet.project_public_subnet_2.id
}

output "pr_sn" {
  value = aws_subnet.project_private_subnet.id
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