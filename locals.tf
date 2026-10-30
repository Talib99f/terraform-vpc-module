
locals {
  availability_zones = length(var.availability_zones) == 3 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, 3)
  common_tags        = merge(var.tags, { ManagedBy = "Terraform" })
}
