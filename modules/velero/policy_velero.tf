resource "aws_iam_policy" "eks_velero_policy" {
  name   = "${var.project_name}-velero-policy"
  policy = file("${path.module}/files/iam_policy_velero.json")
  tags   = var.tags
}
