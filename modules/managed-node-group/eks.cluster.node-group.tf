resource "aws_eks_node_group" "eks_managed_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-nodegroup"
  node_role_arn   = aws_iam_role.eks_mng_role.arn

  subnet_ids = [
    var.private_subnet_1a,
    var.private_subnet_1b
  ]

  ami_type               = var.ami_type
  instance_types         = var.instance_types
  capacity_type          = var.capacity_type

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = aws_launch_template.eks_nodes.latest_version
  }

  scaling_config {
    desired_size = var.auto_scale_options.min
    max_size     = var.auto_scale_options.max
    min_size     = var.auto_scale_options.desired
  }

  labels = {
    "role"   = "app"
    "environment" = "DEV"
    "kind" = "ON_DEMAND"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nodegroup"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_attachment_worker,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_cni
  ]
}
