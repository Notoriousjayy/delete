output "cluster_name" {
  description = "The EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  description = "Base64-encoded CA certificate"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_security_group_id" {
  description = "Primary security group ID for the control plane"
  value       = module.eks.cluster_primary_security_group_id
}

output "managed_node_group_names" {
  description = "List of managed node group names"
  value       = keys(var.managed_node_groups)
}
