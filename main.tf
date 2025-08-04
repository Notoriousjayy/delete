terraform {
  required_version = ">= 1.5"
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# ──────────────────────────────────────────────
# VPC
# ──────────────────────────────────────────────
module "vpc" {
  source  = "./modules/vpc"

  name               = "jordan-prod-eks-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnets    = ["10.0.1.0/24",   "10.0.2.0/24",   "10.0.3.0/24"]
  enable_nat_gateway = true

  tags = {
    Environment = "production"
    Project     = "jordan-prod-eks"
  }
}

# ──────────────────────────────────────────────
# EKS Cluster
# ──────────────────────────────────────────────
module "eks_cluster" {
  source             = "./modules/eks_cluster"
  cluster_name       = "jordan-prod-eks"
  kubernetes_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  managed_node_groups = {
    general = {
      instance_types = ["t3.small"]
      desired_size   = 1
      min_size       = 1
      max_size       = 1
      ami_type       = "AL2023_x86_64_STANDARD"
    }
  }

  tags = {
    Environment = "production"
    Project     = "jordan-prod-eks"
  }
}
