AWS Fast.ai Course Instance
========================

Terraform module to create a workspace instance for [Fast.ai](https://course.fast.ai).

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
