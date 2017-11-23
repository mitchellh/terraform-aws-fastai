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

Usage
-----

```hcl
provider "aws" {
  version = "~> 1.0.0"
  region  = "us-west-2"
}

module "vpc" {
  source = "mitchellh/fastai/aws"
}
```

Terraform version
-----------------

Terraform version 0.11.0 or newer is required for this version to work.
