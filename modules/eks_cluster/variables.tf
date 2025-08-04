variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.33"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "managed_node_groups" {
  type = map(any)
  default = {}
}

// ARN of an already-created EKS cluster IAM role.  Module will **not** create or delete it.
variable "existing_cluster_iam_role_arn" {
  type        = string
  description = "Use an existing IAM role instead of letting the module create one"
}