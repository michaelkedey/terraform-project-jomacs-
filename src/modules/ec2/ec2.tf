resource "aws_instance" "project_instance" {
  instance_type   = "${var.instance_type}" ["project"]
  ami             = data.aws_ami.latest_ubuntu.id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
  user_data       = file("${path.module}/nginx_ssh_config.sh")
  provider        = aws.project_region
  tags = sensitive(
    merge(
      var.tags_all,
      {
        Name = var.names["instance_name"]
      }
    )
  )
  #key exists already in my cloud environment
  #comment the code below to run without key
  key_name = var.key_name
}

