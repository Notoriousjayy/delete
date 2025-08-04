module "this" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name               = var.name
  cidr               = var.cidr
  azs                = var.azs
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway

  tags = var.tags
}
