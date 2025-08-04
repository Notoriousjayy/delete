module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  # Use public endpoints by default
  endpoint_public_access  = true
  endpoint_private_access = false

  # grant your Terraform caller full admin
  enable_cluster_creator_admin_permissions = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_groups = {
    for pool_name, cfg in var.managed_node_groups : pool_name => {
      instance_types       = cfg.instance_types
      desired_size         = cfg.desired_size
      min_size             = cfg.min_size
      max_size             = cfg.max_size
      ami_type             = lookup(cfg, "ami_type", null)
      enable_efa_support   = lookup(cfg, "enable_efa", false)
      # ensure we wait for control-plane before nodes
      before_addons        = true
    }
  }

  # Turn on IRSA for service-account IAM
  enable_irsa = true

  tags = var.tags
}
