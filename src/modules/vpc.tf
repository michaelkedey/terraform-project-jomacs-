#vpc
resource "aws_vpc" "project_vpc" {
  cidr_block = var.cidrs["vpc"]
  provider   = aws.project_region

  tags = {
    Name        = var.names["vpc"]
    Environment = var.project_environment
  }
}

#public subnet
resource "aws_subnet" "project_public_subnet" {
  vpc_id                  = aws_vpc.project_vpc.vpc_id
  cidr_block              = var.cidrs["public_subnet"]
  provider                = aws.project_region
  map_public_ip_on_launch = true

  tags = {
    Name        = var.names["public_subnet"]
    Environment = var.project_environment
  }

}

#private subnet
resource "aws_subnet" "project_private_subnet" {
  vpc_id                  = aws_vpc.project_vpc.vpc_id
  cidr_block              = var.cidrs["private_subnet"]
  provider                = aws.project_region
  map_public_ip_on_launch = false

  tags = {
    Name        = var.names["private_subnet"]
    Environment = var.project_environment
  }

}

#internet gateway
resource "aws_internet_gateway" "project_internet_gateway" {
  vpc_id = aws_vpc.project_vpc.vpc_id

  tags = {
    Name        = var.names["internet_gateway"]
    Environment = var.project_environment
  }
}

#route table
resource "aws_route_table" "project_route_table" {
  vpc_id = aws_vpc.project_vpc.vpc_id
  route {
    cidr_block = var.cidrs["route_table"]
    gateway_id = aws_internet_gateway.project_internet_gateway.id
  }

  tags = {
    Name        = var.names["route_table"]
    Environment = var.project_environment
  }
}

#associate rt with public subnet
resource "aws_route_table_association" "project_route_table" {
  subnet_id      = aws_subnet.project_public_subnet.id
  route_table_id = aws_route_table_association.project_route_table.id
}

#nat gateway
resource "aws_nat_gateway" "project_nat_gateway" {
  allocation_id = aws_eip.project_eip.id
  subnet_id     = aws_subnet.project_public_subnet.id

  tags = {
    Name        = var.names["nat_gateway"]
    Environment = var.project_environment
  }

  depends_on = [aws_internet_gateway.project_internet_gateway]
}

#elastic ip address
resource "aws_eip" "project_eip" {
  instance = var.eip_instance_id
  domain   = var.eip_domain
}

#load balancer
resource "aws_lb" "project_lb" {
  name               = var.names["load_balancer"]
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.project_lb_sg.id]

  subnet_mapping {
    subnet_id     = aws_subnet.project_public_subnet.id
    allocation_id = aws_eip.project_eip.id
  }
}

#load balancer web traffic listener
resource "aws_lb_listener" "project_lb_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = var.ports["lb_listener_web"]
  protocol          = var.protocols["lb_listener_web"]

  default_action {
    type             = var.lb_default_action
    target_group_arn = aws_lb_target_group.example.arn
  }
}

#load balancer ssh traffic listener
resource "aws_lb_listener" "project_lb_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = var.ports["lb_listener_ssh"]
  protocol          = var.protocols["lb_listener_ssh"]

  default_action {
    type             = var.lb_default_action
    target_group_arn = aws_lb_target_group.example.arn
  }
}

#target group for load balancer web
resource "aws_lb_target_group" "project_target_group_web" {
  name     = var.names["web_tg"]
  port     = var.port["lb_listener_web"]
  protocol = var.protocols["lb_listener_web"]
  vpc_id   = aws_vpc.project_vpc.vpc_id

  tags = {
    Name        = var.names["web_tg"]
    Environment = var.project_environment
  }
}


#target group for load balancer custom ssh
resource "aws_lb_target_group" "project_target_group_web" {
  name     = var.names["ssg_tg"]
  port     = var.port["lb_listener_ssh"]
  protocol = var.protocols["lb_listener_ssh"]
  vpc_id   = aws_vpc.project_vpc.vpc_id

  tags = {
    Name        = var.names["ssh_tg"]
    Environment = var.project_environment
  }
}


#security group for load balancer
#necessary in order to set the id for the ingress web traffic in the sg
resource "aws_security_group" "project_lb_sg" {
  name   = var.names["lb_sg"]
  vpc_id = aws_vpc.project_vpc.vpc_id

  tags = {
    Name        = var.names["lb_sg"]
    Environment = var.project_environment
  }

}

#security group for instances
resource "aws_security_group" "project_instance_sg" {
  name     = var.names["sg"]
  vpc_id   = aws_vpc.project_vpc.vpc_id
  provider = aws.project_region

  #this rule allows ssh traffic on a custom port
  ingress {
    from_port   = var.ports["custom_ssh"]
    to_port     = var.ports["custom_ssh"]
    protocol    = var.protocols["sg_in_protocol"]
    cidr_blocks = var.cidrs["sg_ssh_cidr"]
  }
  #this rule allows ingress web traffic from the lb only
  ingress {
    from_port                = var.ports["web"]
    to_port                  = var.ports["web"]
    protocol                 = var.protocols["sg_in_protocol"]
    source_security_group_id = aws_security_group.load_balancer_sg.id
  }

  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.protocols["sg_out_protocol"]
    cidr_blocks = var.cidrs["sg_out_cider"]
  }

  tags = {
    Name        = var.names["instance_sg"]
    Environment = var.project_environment
  }
}