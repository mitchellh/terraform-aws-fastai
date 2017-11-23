output "public_ip" {
  value = "${module.instance.public_ip}"
}

output "ssh_command" {
  value = "ssh -i ./keys/fastai-dev-key ubuntu@${module.instance.public_ip}"
}
