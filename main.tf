data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "fastai-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_availability_zones.available.names[0]}"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
  }
}

module "key" {
  source              = "cloudposse/key-pair/aws"
  namespace           = "fastai"
  stage               = "dev"
  name                = "key"
  ssh_public_key_path = "./keys"
  generate_ssh_key    = "true"
}

module "instance" {
  source        = "./modules/instance"
  vpc_id        = "${module.vpc.vpc_id}"
  subnet_id     = "${module.vpc.public_subnets[0]}"
  instance_type = "${var.instance_type}"
  key_name      = "${module.key.key_name}"
}
