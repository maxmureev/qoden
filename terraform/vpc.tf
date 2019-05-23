##########################################################
# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

##########################################################
# Create security groups
resource "aws_security_group" "web" {
  name        = "${var.env}-web"
  description = "Allow web port"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.env}-web"
  }

  ingress {
    from_port   = "${var.web["port"]}"
    to_port     = "${var.web["port"]}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db" {
  name        = "${var.env}-${var.db["name"]}"
  description = "Allow ${var.db["name"]} port"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.env}-${var.db["name"]}"
  }

  ingress {
    from_port   = "${var.db["port"]}"
    to_port     = "${var.db["port"]}"
    protocol    = "tcp"
    cidr_blocks = "${var.subnet_cidr}"
  }
}

resource "aws_security_group" "all" {
  name        = "${var.env}-all"
  description = "Allow SSH, ping and output traffic"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.env}-all"
  }

  ingress {
    from_port   = "${var.ports["ssh"]}"
    to_port     = "${var.ports["ssh"]}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ping
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Output internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
