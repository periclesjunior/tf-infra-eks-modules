output "node_group_ids" {
  description = "Managed node group IDs keyed by node group name."
  value       = { for name, group in aws_eks_node_group.eks_managed_node_group : name => group.id }
}

output "node_group_arns" {
  description = "Managed node group ARNs keyed by node group name."
  value       = { for name, group in aws_eks_node_group.eks_managed_node_group : name => group.arn }
}

output "launch_template_ids" {
  description = "Launch template IDs keyed by node group name."
  value       = { for name, lt in aws_launch_template.eks_nodes : name => lt.id }
}
