variable "instance_type" {
  type = map(string)
  default = {
    project    = "t2.micro",
    production = "m5.large"
  }
  description = "instance type for project server"
}

variable "subnet_id" {
  description = "subnet id to launch instance in"
  type        = string
}

variable "security_groups" {
  type        = set(string)
  description = "security group to deploy server in"
}

variable "names" {
  default = {
    instance_name = "jp_server"
  }
  type = map(string)
}

variable "key_name" {
  default = "ginakey"
  type    = string
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