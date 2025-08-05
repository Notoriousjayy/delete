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

# 1) Reference your already-existing EKS node-group role
data "aws_iam_role" "eks_node_group" {
  name = "general-eks-node-group-20250804203258481500000001"
}

module "vpc" {
  source          = "./modules/vpc"
  name            = "demo-vpc"
  cidr            = "10.1.0.0/16"
  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets = ["10.1.11.0/24", "10.1.12.0/24"]
}

module "eks_cluster" {
  source             = "./modules/eks_cluster"
  cluster_name       = "jordan-prod-eks"
  kubernetes_version = "1.33"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnets

  # ← Tell the module to create (and later destroy) the control-plane IAM role
  create_cluster_iam_role = true

  managed_node_groups = {
    default = {
      create_iam_role          = false
      iam_role_arn             = data.aws_iam_role.eks_node_group.arn
      iam_role_use_name_prefix = false

      instance_types = ["t3.small"]
      desired_size   = 1
      min_size       = 1
      max_size       = 1
    }
  }
}
