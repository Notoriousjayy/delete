variable "cluster_name" {
  description = "Name to assign to the EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version (e.g. \"1.27\")."
  type        = string
  default     = "1.27"
}

variable "vpc_id" {
  description = "VPC ID where the cluster & nodes will live."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for control plane & nodes."
  type        = list(string)
}

variable "managed_node_groups" {
  description = <<-EOT
    Map of managed node group settings.
    Key = pool name; Value = object with
      - instance_types  = list(string)
      - desired_size    = number
      - min_size        = number
      - max_size        = number
      - ami_type        = optional(string) e.g. \"AL2023_x86_64_STANDARD\"
      - enable_efa      = optional(bool)
  EOT
  type = map(object({
    instance_types = list(string)
    desired_size   = number
    min_size       = number
    max_size       = number
    ami_type       = optional(string)
    enable_efa     = optional(bool)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to add to all EKS resources."
  type        = map(string)
  default     = {}
}
