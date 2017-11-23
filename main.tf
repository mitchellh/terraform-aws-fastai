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

  tags = {
    Terraform = "true"
  }
}

//-------------------------------------------------------------------
// Data

data "aws_region" "current" {
  current = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

//-------------------------------------------------------------------
// Resources

resource "aws_security_group" "fastai" {
  description = "Fast.ai instance security group"
  vpc_id      = "${module.vpc.vpc_id}"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jupyter
  ingress {
    from_port   = 8888
    to_port     = 8898
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance" {
  ami                    = "${var.ami_map[data.aws_region.current.name]}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${module.vpc.public_subnets[0]}"
  vpc_security_group_ids = ["${aws_security_group.fastai.id}"]
  key_name               = "${var.key_name}"

  tags = {
    Name = "Fast.ai Course Instance"
  }
}

resource "aws_eip" "instance" {
  instance = "${aws_instance.instance.id}"
  vpc      = true
}
