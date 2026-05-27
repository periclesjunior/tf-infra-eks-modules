resource "helm_release" "cluster_autoscaler" {
  name       = "aws-cluster-autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.57.0"
  repository = "https://kubernetes.github.io/autoscaler"
  namespace  = "kube-system"

  set = [
    {
      name  = "replicaCount"
      value = 1
    },
    {
      name  = "awsRegion"
      value = var.region
    },
    {
      name  = "rbac.serviceAccount.create"
      value = true
    },
    {
      name  = "rbac.serviceAccount.name"
      value = "cluster-autoscaler-sa"
    },
    {
      name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.cluster_autoscaler.arn
    },
    {
      name  = "autoDiscovery.clusterName"
      value = var.cluster_name
    }
  ]

}
