AWS Fast.ai Course Instance
========================

Terraform module to create a workspace instance for [Fast.ai](https://course.fast.ai).

This module will automatically create the full VPC as well as a temporary
SSH key pair for use with the instance. The expectation is that this is a
temporary workspace for working with Fast.ai and new credentials can be
generated each time.

For advanced usage, you may provide the VPC and other parameters by using
the "modules/instance" nested module directly. This will not automatically
generate a keypair or VPC.

What This Module Does
---------------------

Features:

  * Creates a VPC and all related VPC resources (subnets, internet gateways,
    routing tables, etc.)

  * Generates a temporary SSH keypair for accessing the created instance.
    The keypair is placed into the "keys/" directory relative to the
    root module.

  * Launches a GPU (p2 class) EC2 instance using the official Fast.ai AMIs.

Usage
-----

Run `terraform apply` against the example configuration below:

```hcl
provider "aws" {
  version = "~> 1.0.0"
  region  = "us-west-2"
}

module "fastai" {
  source = "mitchellh/fastai/aws"
}

output "ssh_command" {
  value = "${module.fastai.ssh_command}"
}
```

After running it, inspect the output `ssh_command`. This will contain
the SSH command to use to connect to the instance. On initial creation this
may take up to a minute to connect successfully.

**Note:** As a security precaution, please ensure that the command is what
you expect before executing it, or copy and paste the command to execute it.

```sh
$ terraform output ssh_command
ssh -i ./keys/fastai-dev-key ubuntu@127.0.0.1

$ $(terraform output ssh_command)
ubuntu@ip-10-0-101-210:~$
```

The SSH keys created are also in the `./keys` subdirectory relative to
the root Terraform configuration if you need those for any other reason.
These keys will be automatically deleted and removed when your configuration
is destroyed (via `terraform destroy`).

Terraform version
-----------------

Terraform version 0.11.0 or newer is required for this version to work.
