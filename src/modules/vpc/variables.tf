#vpc variables
variable "cidrs" {

  default = {
    vpc             = "177.70.0.0/24",
    public_subnet   = "177.70.0.0/26",
    private_subnet  = "177.70.0.64/26",
    public_subnet_2 = "177.70.0.128/26",
    route_table     = "0.0.0.0/0",
  }

  sensitive   = true
  type        = map(string)
  description = "cidr blocks for vpc components"
}

variable "sg_ssh_cidr" {
  default   = ["0.0.0.0/0"]
  type      = list(string)
  sensitive = true
}

variable "sg_out_cidr" {
  default   = ["0.0.0.0/0"]
  type      = list(string)
  sensitive = true
}

variable "names" {

  default = {
    vpc              = "jp_vpc",
    public_subnet    = "jp_vpc_bublic_sn",
    public_subnet_2  = "jp_vpc_bublic_sn2",
    private_subnet   = "jp_vpc_private_sn",
    internet_gateway = "jp_internet_gw",
    route_table      = "jp_igw_rt",
    nat_gateway      = "jp_nat_gw",
    load-balancer    = "jp-lb",
    lb_target_group  = "jp_lb_tg",
    target_group_web = "jp_lb_listener_tg_web",
    target_group_ssh = "jp_lb_listener_tg_ssh",
    web-tg           = "jp-web-target-group",
    ssh_tg           = "jp_ssh_target_group",
    lb_sg            = "jp_load_balancer_sg",
    instance_sg      = "jp_instance_sg",
    lb               = "jp_lb",
  }

  sensitive   = true
  type        = map(string)
  description = "tags for vpc resources"
}

variable "azs" {
  default   = ["us-east-1a", "us-east-1b"]
  type      = list(string)
  sensitive = true
}
variable "project_environment" {
  default   = "jomacs_project"
  type      = string
  sensitive = true
}

variable "eip_instance_id" {

}

variable "eip_domain" {
  default   = "vpc"
  type      = string
  sensitive = true
}

variable "load_balancer_type" {
  default = "application"
  type    = string
}

variable "ports" {
  default = {
    lb_listener = 80,
    custom_ssh  = 770,
    all         = 0
  }
  sensitive = true
  type      = map(number)
}

variable "sg_out_protocol" {
  default   = -1
  type      = string
  sensitive = true
}

variable "tg_protocol" {
  default   = "HTTP"
  type      = string
  sensitive = true
}

variable "sg_in_protocol" {
  default     = ["tcp"]
  description = "allow only tcp traffic in"
  type        = list(string)
  sensitive   = true
}

variable "lb_default_action" {
  default   = "forward"
  type      = string
  sensitive = true
}

