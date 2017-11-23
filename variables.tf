variable "key_name" {
  description = "AWS keypair name for the instance."
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

variable "region" {
  description = "AWS region to launch the instance."
  default     = "us-west-2"
}

variable "zones" {
  type    = "list"
  default = ["us-west-2a"]
}
