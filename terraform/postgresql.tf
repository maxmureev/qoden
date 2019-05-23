resource "aws_db_instance" "postgre" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "${var.db["engine_version"]}"
  instance_class         = "${var.db["instance_type"]}"
  username               = "${var.db_user}"
  password               = "${var.db_pass}"
  db_subnet_group_name   = "${aws_db_subnet_group.db.id}"
  vpc_security_group_ids = ["${aws_security_group.all.id}", "${aws_security_group.db.id}"]
  identifier             = "${var.env}-postgresql"
  skip_final_snapshot    = true
  publicly_accessible    = false

  #  name                 = "postgresql"  # По условию задачи база должна создаваться Ansible'м на этапе настройки инфраструктуры
}

resource "aws_db_subnet_group" "db" {
  name        = "db"
  description = "Our main group of subnets"
  subnet_ids  = "${aws_subnet.public.*.id}"
}
