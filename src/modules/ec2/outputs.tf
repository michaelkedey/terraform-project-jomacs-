output "eip_instance_id" {
  value = aws_instance.project_instance.id  
}

output "eip_address" {
  value = aws_eip_association.project_instance_eip.public_ip
  description = "The public IP address of the instance"
}


