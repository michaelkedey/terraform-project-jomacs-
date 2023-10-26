#vpc variables
variable "cidrs" {

  default = {
    vpc             = "177.70.0.0/24",
    public_subnet   = "177.70.0.0/26",
    private_subnet  = "177.70.0.64/26",
    public_subnet_2 = "177.70.0.128/26",
    default_route   = "0.0.0.0/0"
  }

  sensitive   = true
  type        = map(string)
  description = "cidr blocks for vpc components"
}

variable "lb_out_cidr" {
  default   = ["177.70.0.64/26"]
  type      = list(string)
  sensitive = true
}

variable "default_route" {
  default   = ["0.0.0.0/0"]
  type      = list(string)
  sensitive = true
}

variable "names" {

  default = {
    vpc           = "jp_vpc",
    public_subnet = "jp_vpc_bublic_sn",

    public_subnet_2     = "jp_vpc_bublic_sn2",
    private_subnet      = "jp_vpc_private_sn",
    internet_gateway    = "jp_internet_gw",
    public_route_table  = "jp_public_rt",
    private_route_table = "jp_private_rt"
    internet_gateway    = "jp_igw",
    nat_gateway         = "jp-nat_gw",
    load-balancer       = "jp-load-balancer",
    lb_target_group     = "jp_lb_tg",
    target_group_web    = "jp_lb_listener_tg_web",
    target_group_ssh    = "jp_lb_listener_tg_ssh",
    web-tg              = "jp-web-target-group",
    lb_sg               = "jp_load_balancer_sg",
    instance_sg         = "jp_instance_sg",
    lb                  = "jp_lb"
  }

  sensitive   = true
  type        = map(string)
  description = "tags for vpc resources"
}

variable "tags_all" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  sensitive   = true
  default = {
    "Environment" = "jomacs_project",
    "Owner"       = "Michael Kedey"
  }
}

variable "azs" {
  default   = ["us-east-1a", "us-east-1b"]
  type      = list(string)
  sensitive = true
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
    custom_web = 80,
    custom_ssh = 273,
    all        = 0
  }
  sensitive = true
  type      = map(number)
}

variable "protocols" {
  default     = ["HTTP", -1, "tcp"]
  description = "allow only tcp traffic in"
  type        = list(any)
  sensitive   = true
}

variable "lb_default_action" {
  default   = "forward"
  type      = string
  sensitive = true
}

variable "instance_id" {

}
