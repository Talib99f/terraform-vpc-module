variable "name" {
  description = "Name prefix applied to the VPC resources."
  type        = string
  default     = "app"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the three public subnets, in availability-zone order."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) == 3
    error_message = "Provide exactly three public subnet CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the three private subnets, in availability-zone order."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  validation {
    condition     = length(var.private_subnet_cidrs) == 3
    error_message = "Provide exactly three private subnet CIDR blocks."
  }
}

variable "availability_zones" {
  description = "Three availability zones to use. If empty, the first three available zones in the selected region are used."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.availability_zones) == 0 || length(var.availability_zones) == 3
    error_message = "Provide either no availability zones or exactly three."
  }
}

variable "tags" {
  description = "Additional tags applied to all resources that support tags."
  type        = map(string)
  default     = {}
}

variable "security_group_ingress_rules" {
  description = "Optional IPv4 ingress rules for the VPC security group. Leave empty to allow no inbound traffic."
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
