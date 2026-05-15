resource "kubernetes_service_account_v1" "eks_velero_sa" {
  metadata {
    name      = "velero"
    namespace = "velero"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks_velero_role.arn
    }
  }
}
