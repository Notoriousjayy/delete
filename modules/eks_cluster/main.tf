module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_groups = {
    for name, cfg in var.managed_node_groups : name => {
      instance_types = cfg.instance_types
      desired_size   = cfg.desired_size
      min_size       = cfg.min_size
      max_size       = cfg.max_size
    }
  }
}
