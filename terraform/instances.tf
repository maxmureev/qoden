##########################################################
# Create Public Key For SSH
resource "aws_key_pair" "key" {
  key_name   = "${var.main["key_name"]}"
  public_key = "${var.main["public_key"]}"
}

##########################################################
# Web
# Create Public Elastic IPs
resource "aws_eip" "web" {
  instance = "${element(aws_instance.web.*.id, count.index)}"
  count    = "${var.web["count"]}"
}

# Create Web Instance
resource "aws_instance" "web" {
  ami                         = "${var.main["ami"]}"
  availability_zone           = "${element(var.zones, count.index)}"
  instance_type               = "${var.web["instance_type"]}"
  count                       = "${var.web["count"]}"
  key_name                    = "${var.main["key_name"]}"
  vpc_security_group_ids      = ["${aws_security_group.all.id}", "${aws_security_group.web.id}"]
  subnet_id                   = "${element(aws_subnet.public.*.id, count.index)}"
  associate_public_ip_address = true
  source_dest_check           = false

  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
  }

  tags = {
    Name = "${format("${var.env}-${element(var.alias, count.index)}-${var.web["name"]}-%02d", count.index)}"
    env  = "${var.env}"
  }

  user_data = "${element(data.template_file.web.*.rendered, count.index)}"
}

data "template_file" "web" {
  template = "${file("init.tpl")}"
  count    = "${var.web["count"]}"

  vars = {
    hostname = "${format("${var.env}-${element(var.alias, count.index)}-${var.web["name"]}-%02d", count.index)}"
  }
}
