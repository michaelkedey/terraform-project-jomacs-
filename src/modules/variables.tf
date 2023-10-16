#vpc variables
variable "cidrs"{

    default = {
        vpc = "177.70.11.7/16",
        public_subnet = "177.70.0.0/17",
        private_subnet = "177.70.128.0/17",
        route_table = "0.0.0.0/0"
    }
    type = map(string)
    description = "cidr blocks for vpc components"
}

variable "names"{

    default = {
        vpc = "jp_vpc",
        public_subnet = "jp_vpc_bublic_sn",
        private_subnet = "jp_vpc_private_sn",
        internet_gateway = "jp_internet_gw",
        route_table = "jp_igw_rt",
        nat_gateway = "jp_nat_gw",
        load_balancer = "jp_lb",
        lb_target_group = "jp_lb_tg",
        target_group_web = "jp_lb_listener_tg_web",
        target_group_ssh = "jp_lb_listener_tg_ssh",
        web_tg = "jp_web_target_group",
        ssh_tg = "jp_ssh_target_group",
        lb_sg = "jp_load_balancer_sg"
    }
    type = map(string)
    description = "tags for vpc resources"
}

variable "project_environment" {
  default = "jomacs_project"
  type = string
}

variable "eip_instance_id" {
  
}

variable "eip_domain" {
    default = "vpc" 
    type = string
}

variable "load_balancer_type" {
    default = "application"
    type = string
}

variable "ports" {

    default = {
        lb_listener_web = 80,
        lb_listener_ssh = 273,

    }
    type = map(number)
}

variable "protocols" {

    default = {
        lb_listener_web = "HTTP"
        lb_listener_ssh = "ssh"
    }
    type = map(string)
}

variable "lb_default_action" {
    default = "forward"
    type = string
}


#security group for instances
resource "aws_security_group" "project_instance_sg" {
  name     = var.names["sg"]
  vpc_id = aws_vpc.project_vpc.vpc_id
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
    from_port   = var.ports["web"]
    to_port     = var.ports["web"]
    protocol    = var.protocols["sg_in_protocol"]
    source_security_group_id = aws_security_group.load_balancer_sg.id
  }

  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.protocols["sg_out_protocol"]
    cidr_blocks = var.cidrs["sg_out_cider"]
  }

  tags = {
      Name = var.names["instance_sg"]
      Environment = var.project_environment
    }
}