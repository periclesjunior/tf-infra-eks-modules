output "managed_node_group_ids" {
  description = "Managed node group IDs keyed by node group name."
  value       = module.eks_managed_node_group.node_group_ids
}

output "managed_node_group_arns" {
  description = "Managed node group ARNs keyed by node group name."
  value       = module.eks_managed_node_group.node_group_arns
}

output "managed_node_group_launch_template_ids" {
  description = "Launch template IDs keyed by node group name."
  value       = module.eks_managed_node_group.launch_template_ids
}
