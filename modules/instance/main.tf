data "aws_region" "current" {
  current = true
}

resource "aws_security_group" "fastai" {
  description = "Fast.ai instance security group"
  vpc_id      = "${var.vpc_id}"

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
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.fastai.id}"]
  key_name               = "${var.key_name}"

  tags = {
    Name = "Fast.ai Course Instance"
  }

  provisioner "remote-exec" {
    script = "${path.module}/setup.sh"

    connection {
      user        = "ubuntu"
      private_key = "${var.private_key}"
    }
  }
}

resource "aws_eip" "instance" {
  instance = "${aws_instance.instance.id}"
  vpc      = true
}
