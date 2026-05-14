resource "aws_eks_access_entry" "cluster_access_entry" {
  for_each = var.access_entries

  cluster_name      = aws_eks_cluster.eks_cluster.name
  principal_arn     = each.value.principal_arn
  type              = try(each.value.type, "STANDARD")
  kubernetes_groups = try(each.value.kubernetes_groups, null)

  tags = var.tags
}

resource "aws_eks_access_policy_association" "cluster_access_policy_association" {
  for_each = {
    for item in flatten([
      for entry_key, entry in var.access_entries : [
        for policy_key, policy in lookup(entry, "policy_associations", {}) : {
          key           = "${entry_key}|${policy_key}"
          principal_arn = entry.principal_arn
          policy_arn    = policy.policy_arn
          scope_type    = policy.access_scope.type
          namespaces    = lookup(policy.access_scope, "namespaces", [])
        }
      ]
    ]) : item.key => item
  }

  cluster_name  = aws_eks_cluster.eks_cluster.name
  principal_arn = each.value.principal_arn
  policy_arn    = each.value.policy_arn

  access_scope {
    type       = each.value.scope_type
    namespaces = each.value.namespaces
  }

  depends_on = [aws_eks_access_entry.cluster_access_entry]
}
