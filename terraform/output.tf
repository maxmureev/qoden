output "web_public_ips" {
  value = ["${aws_eip.web.*.public_ip}"]
}

output "db_endpoint" {
  value = "${aws_db_instance.postgre.address}"
}
