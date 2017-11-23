output "ip_address" {
  value = "${aws_eip.instance.public_ip}"
}
