resource "aws_iam_policy" "eks_controller_policy" {
  name   = "${var.project_name}-aws-load-balancer-controller"
  policy = file("${path.module}/files/iam_policy_aws_lb_controller.json")
  tags   = var.tags
}
