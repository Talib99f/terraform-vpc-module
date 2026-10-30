# Terraform AWS VPC module

Creates one VPC with three public subnets and three private subnets across three
availability zones. All public subnets share one route table with a default
route to the internet gateway. All private subnets share one route table with
a default route through one NAT gateway in the first public subnet.

## Example

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./terraform-vpc-module"

  name       = "production"
  vpc_cidr   = "10.0.0.0/16"
  tags       = { Environment = "production" }

  # Optional. Inbound traffic is blocked when this is omitted.
  security_group_ingress_rules = [
    {
      description = "SSH from my trusted IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.10/32"]
    }
  ]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "security_group_id" {
  value = module.vpc.security_group_id
}
```

When using a remote module, replace `source` with its Git or registry source.
The module picks the first three available availability zones in the configured
region by default. You can set `availability_zones` explicitly to choose them.

The NAT gateway and its Elastic IP incur AWS charges while they exist.
