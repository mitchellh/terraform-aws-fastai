output "public_ip" {
  value = "${module.instance.public_ip}"
}

output "ssh_command" {
  value = "ssh -i ${local.private_key_filename} ubuntu@${module.instance.public_ip}"
}
