#create an ssm resource to store the network resources
resource "aws_ssm_parameter" "vpc" {
  name  = format("/%s/%s/%s", "jomacs", "terraform-p", "vpc")
  type  = "String"
  value = aws_vpc.project_vpc.id
}

resource "aws_ssm_parameter" "pb_sn_1" {
  name  = format("/%s/%s/%s", "jomacs", "terraform-p", "pb_sn_1")
  type  = "String"
  value = aws_subnet.project_public_subnet.id
}

resource "aws_ssm_parameter" "pb_sn_2" {
  name  = format("/%s/%s/%s", "jomacs", "terraform-p", "pb_sn_2")
  type  = "String"
  value = aws_subnet.project_public_subnet_2.id
}

resource "aws_ssm_parameter" "pv_sn" {
  name  = format("/%s/%s/%s", "jomacs", "terraform-p", "pv_sn")
  type  = "String"
  value = aws_subnet.project_private_subnet.id
}

resource "aws_ssm_parameter" "instance_sg" {
  name  = format("/%s/%s/%s", "jomacs", "terraform-p", "instance_sg")
  type  = "String"
  value = aws_security_group.project_instance_sg.id
}