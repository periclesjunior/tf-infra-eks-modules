resource "aws_eks_node_group" "eks_managed_node_group" {
  for_each = var.node_groups

  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-${each.key}"
  node_role_arn   = aws_iam_role.eks_mng_role.arn
  subnet_ids      = var.subnet_ids

  ami_type       = each.value.ami_type
  instance_types = each.value.instance_types
  capacity_type  = each.value.capacity_type

  dynamic "launch_template" {
    for_each = each.value.create_launch_template ? [1] : []

    content {
      id      = aws_launch_template.eks_nodes[each.key].id
      version = aws_launch_template.eks_nodes[each.key].latest_version
    }
  }

  scaling_config {
    min_size     = each.value.min_size
    max_size     = each.value.max_size
    desired_size = each.value.desired_size
  }

  labels = each.value.labels

  dynamic "taint" {
    for_each = each.value.taints

    content {
      effect = taint.value.effect
      key    = taint.value.key
      value  = taint.value.value
    }
  }

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name      = "${var.project_name}-${each.key}"
      NodeGroup = each.key
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_attachment_worker,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_cni
  ]
}
