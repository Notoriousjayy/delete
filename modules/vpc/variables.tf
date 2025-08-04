variable "name" {
  description = "Base name for all VPC resources"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of AZs, e.g. [\"us-east-1a\",\"us-east-1b\",\"us-east-1c\"]"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT Gateways (for internet egress from private subnets)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all VPC resources"
  type        = map(string)
  default     = {}
}
