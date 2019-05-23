##########################################################
# AWS Part
variable "env" {
  default = "qoden"
}

variable "region" {
  default = "us-east-1"
}

variable "profile" {
  default = "qoden"
}

variable "db_user" {}

variable "db_pass" {}

##########################################################
# AWS Vars
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

##########################################################
# Subnets Vars
variable "cloud_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_cidr" {
  default = "10.0.0.0/22"
}

variable "subnet_cidr" {
  type    = "list"
  default = ["10.0.0.0/28", "10.0.0.16/28"]
}

variable "count_subnet" {
  default = "2"
}

##########################################################
# Main Vars
variable "zones" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b"]
}

variable "alias" {
  default = ["ue1a", "ue1b"]
}

variable "main" {
  type = "map"

  default = {
    ami        = "ami-0a313d6098716f372"
    user       = "ubuntu"
    key_name   = "my_ssh_key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFFAEsu9b74YAkEHxfP3vpRaQBul0BPj6FrrDYPgNscPE7n8NbKUZs1FhrlkwqhKAaa9fTpG63D3XbzU7CaojtvXw6KcMdCGb3e4RlhxVqshM+PTrpFkQXSokyrhQSGjlj9n78zvHxUYD9ireshJnsRw5WTy+ilLpAc90zepXxJW5YZOGX3dDtTQ2BXhjbdV/0Ww1icTzw/pll441+ZCiH45xT0sAQ48oDs8OQXGIh37zeULSTV22qKLRYKoFBa9lrcJXbr+zq2NUXViEJ8wPFceI20l6bbhOr4RW9+v06t7TRqSnIERjm6NnXf3v4dSwqDMONQBg2zv+DiRO1l8B3 mureevms"
  }
}

##########################################################
# Nodes Description
variable "web" {
  type = "map"

  default = {
    name          = "web"
    count         = 1
    instance_type = "t2.micro"
    port          = 80
  }
}

variable "db" {
  type = "map"

  default = {
    name           = "db"
    instance_type  = "db.t2.micro"
    port           = 5432
    engine_version = 11.2
  }
}

##########################################################
# Open Ports
variable "ports" {
  type = "map"

  default = {
    ssh = 22
  }
}
