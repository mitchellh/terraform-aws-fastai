data "aws_availability_zones" "available" {
  state = "available"
}

//-------------------------------------------------------------------
// Modules

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "fastai-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_availability_zones.available.names[0]}"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
  }
}

module "instance" {
  source        = "./modules/instance"
  vpc_id        = "${module.vpc.vpc_id}"
  subnet_id     = "${module.vpc.public_subnets[0]}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.generated.key_name}"
  private_key   = "${tls_private_key.generated.private_key_pem}"
}

//-------------------------------------------------------------------
// Resources

locals {
  public_key_filename  = "${path.root}/keys/public.pub"
  private_key_filename = "${path.root}/keys/private.pem"
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated" {
  key_name   = "fastai-${uuid()}"
  public_key = "${tls_private_key.generated.public_key_openssh}"

  lifecycle {
    ignore_changes = ["key_name"]
  }
}

resource "local_file" "public_key_openssh" {
  content  = "${tls_private_key.generated.public_key_openssh}"
  filename = "${local.public_key_filename}"
}

resource "local_file" "private_key_pem" {
  content  = "${tls_private_key.generated.private_key_pem}"
  filename = "${local.private_key_filename}"
}
