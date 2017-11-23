output "public_ip" {
  description = "Public IP of the instance."
  value       = "${aws_eip.instance.public_ip}"
}
