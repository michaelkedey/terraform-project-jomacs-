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
    vpc              = format("%s_%s", "jp", "vpc"),
    public_subnet    = format("%s_%s", "jp", "vpc_bublic_sn"),
    public_subnet_2  = format("%s_%s", "jp", "vpc_bublic_sn2"),
    private_subnet   = format("%s_%s", "jp", "vpc_private_sn"),
    internet_gateway = format("%s_%s", "jp", "internet_gw"),
    route_table      = format("%s_%s", "jp", "igw_rt"),
    nat_gateway      = format("%s_%s", "jp", "nat_gw"),
    load-balancer    = format("%s_%s", "jp", "lb"),
    lb_target_group  = format("%s_%s", "jp", "lb_tg"),
    target_group_web = format("%s_%s", "jp", "lb_listener_tg_web"),
    target_group_ssh = format("%s_%s", "jp", "lb_listener_tg_ssh"),
    web-tg           = format("%s_%s", "jp", "web-target-group"),
    ssh_tg           = format("%s_%s", "jp", "ssh_target_group"),
    lb_sg            = format("%s_%s", "jp", "load_balancer_sg"),
    instance_sg      = format("%s_%s", "jp", "instance_sg"),
    lb               = format("%s_%s", "jp", "lb")
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

