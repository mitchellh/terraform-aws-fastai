output "public_ip" {
  description = "Public IP of the Fast.ai course instance."
  value = "${module.instance.public_ip}"
}

output "ssh_command" {
  description = "Command to use to immediately SSH into the instance. This is pre-configured with the temporary SSH key created."
  value = "ssh -i ${local.private_key_filename} ubuntu@${module.instance.public_ip}"
}
