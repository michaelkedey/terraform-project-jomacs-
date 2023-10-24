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
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.cidrs["public_subnet"]
  provider          = aws.project_region
  availability_zone = var.azs[0]

  tags = {
    Name        = var.names["public_subnet"]
    Environment = var.project_environment
  }

}

#public subnet 2
resource "aws_subnet" "project_public_subnet_2" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.cidrs["public_subnet_2"]
  provider          = aws.project_region
  availability_zone = var.azs[1]
  #map_public_ip_on_launch = true

  tags = {
    Name        = var.names["public_subnet_2"]
    Environment = var.project_environment
  }

}

#private subnet
resource "aws_subnet" "project_private_subnet" {
  vpc_id     = aws_vpc.project_vpc.id
  cidr_block = var.cidrs["private_subnet"]
  provider   = aws.project_region

  tags = {
    Name        = var.names["private_subnet"]
    Environment = var.project_environment
  }

}

#eip needed to work with the nat gateway
resource "aws_eip" "project_eip" {
  #instance = var.instance_id
}

/* resource "aws_eip_association" "project_eip_association" {
  instance_id   = var.instance_id
  allocation_id = aws_eip.project_eip
} */


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

#internet gateway
resource "aws_internet_gateway" "project_internet_gateway" {
  vpc_id = aws_vpc.project_vpc.id
  tags = {
    Name        = var.names["internet_gateway"]
    Environment = var.project_environment
  }
}

#public route table
resource "aws_route_table" "project_public_route_table" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block = var.cidrs["route_table"]
    gateway_id = aws_internet_gateway.project_internet_gateway.id
  }

  tags = {
    Name        = var.names["public_route_table"]
    Environment = var.project_environment
  }
}

#associate rt with public subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.project_public_subnet.id
  route_table_id = aws_route_table.project_public_route_table.id
}

#private route table
resource "aws_route_table" "project_private_route_table" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block     = var.cidrs["route_table"]
    nat_gateway_id = aws_nat_gateway.project_nat_gateway.id
  }
  tags = {
    Name        = var.names["private_route_table"]
    Environment = var.project_environment
  }
}

#associate rt with private subnet
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.project_private_subnet.id
  route_table_id = aws_route_table.project_private_route_table.id
}

#load balancer
resource "aws_lb" "project_lb" {
  name               = var.names["load-balancer"]
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.project_lb_sg.id]
  subnets            = [aws_subnet.project_public_subnet.id, aws_subnet.project_public_subnet_2.id]
  #enable_deletion_protection = true

  tags = {
    Name        = var.names["lb"]
    Environment = var.project_environment
  }
}

#load balancer traffic listener
resource "aws_lb_listener" "project_lb_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = var.ports["lb_listener"]
  protocol          = var.tg_protocol

  default_action {
    type             = var.lb_default_action
    target_group_arn = aws_lb_target_group.project_target_group.arn
  }
}

#target group for load balancer
resource "aws_lb_target_group" "project_target_group" {
  name     = var.names["web-tg"]
  port     = var.ports["lb_listener"]
  protocol = var.tg_protocol
  vpc_id   = aws_vpc.project_vpc.id

  tags = {
    Name        = var.names["web-tg"]
    Environment = var.project_environment
  }
}

#associate the instance with the target group
resource "aws_lb_target_group_attachment" "project_tg_attachment" {
  target_group_arn = aws_lb_target_group.project_target_group.arn
  target_id        = var.instance_id
  port             = var.ports["lb_listener"]
}

#security group for load balancer
#necessary in order to set the id for the ingress web traffic in the sg
resource "aws_security_group" "project_lb_sg" {
  ingress {
    from_port   = var.ports["lb_listener"]
    to_port     = var.ports["lb_listener"]
    protocol    = var.sg_in_protocol[0]
    cidr_blocks = var.sg_out_cidr
  }

  egress {
    from_port   = var.ports["lb_listener"]
    to_port     = var.ports["lb_listener"]
    protocol    = var.sg_in_protocol[0]
    cidr_blocks = var.lb_out_cidr
  }
  name   = var.names["lb_sg"]
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name        = var.names["lb_sg"]
    Environment = var.project_environment
  }

}

#security group for instances
resource "aws_security_group" "project_instance_sg" {
  name     = var.names["instance_sg"]
  vpc_id   = aws_vpc.project_vpc.id
  provider = aws.project_region

  #this rule allows ssh traffic on a custom port
  ingress {
    from_port   = var.ports["custom_ssh"]
    to_port     = var.ports["custom_ssh"]
    protocol    = var.sg_in_protocol[0]
    cidr_blocks = var.sg_ssh_cidr
  }
  #this rule allows ingress web traffic from the lb only
  ingress {
    from_port       = var.ports["lb_listener"]
    to_port         = var.ports["lb_listener"]
    protocol        = var.sg_in_protocol[0]
    security_groups = [aws_security_group.project_lb_sg.id]
  }
  #this rule allows web traffic from a proxy server on the instance
  ingress {
    from_port   = var.ports["lb_listener"]
    to_port     = var.ports["lb_listener"]
    protocol    = var.sg_in_protocol[0]
    cidr_blocks = var.localhost
  }

  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.sg_out_protocol
    cidr_blocks = var.sg_out_cidr

  }

  tags = {
    Name        = var.names["instance_sg"]
    Environment = var.project_environment
  }
}