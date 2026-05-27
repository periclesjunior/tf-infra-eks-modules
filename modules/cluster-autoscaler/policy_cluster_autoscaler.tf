resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name   = "${var.project_name}-cluster-autoscaler-policy"
  policy = file("${path.module}/files/iam_policy_cluster_autoscaler.json")

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cluster-autoscaler-policy"
    }
  )
}
