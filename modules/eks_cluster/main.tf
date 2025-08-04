module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  # ─────────────────────────────────────────────────────────────────────────────
  # Never manage the cluster’s IAM role or its policies
  create_iam_role        = false
  iam_role_arn           = var.existing_cluster_iam_role_arn  # point at an existing role
  # ─────────────────────────────────────────────────────────────────────────────
  # Never create a KMS key or the encryption policy
  create_kms_key         = false
  # ─────────────────────────────────────────────────────────────────────────────
  # Don’t create the CloudWatch Log Group (avoids “already exists” errors)
  create_cloudwatch_log_group = false
  # ─────────────────────────────────────────────────────────────────────────────

  # Pass your node-group map through untouched (so its create_iam_role=false flags stick)
  eks_managed_node_groups = var.managed_node_groups
}
