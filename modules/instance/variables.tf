variable "key_name" {
  description = "AWS keypair name for SSH to the instance."
}

variable "private_key" {
  description = "Private key contents. Use the file() interpolation to read files."
}

variable "vpc_id" {
  description = "VPC to create the instance in."
}

variable "subnet_id" {
  description = "Subnet to launch the instance in."
}

variable "ami_map" {
  description = "Map of AMIs by region. These default to the Fast.AI AMIs."

  type = "map"

  default = {
    "us-west-2" = "ami-bc508adc"
    "us-east-1" = "ami-31ecfb26"
    "eu-west-1" = "ami-b43d1ec7"
  }
}

variable "instance_type" {
  description = "Instance type, must be a GPU instance."
  default     = "p2.xlarge"
}
