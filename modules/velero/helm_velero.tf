resource "kubernetes_namespace_v1" "velero" {
  metadata {
    labels = {
      name = "velero"
    }
    name = "velero"
  }
}

resource "helm_release" "eks_helm_velero" {
  name       = "velero"
  repository = "https://vmware-tanzu.github.io/helm-charts"
  chart      = "velero"
  version    = "12.0.1"
  namespace  = kubernetes_namespace_v1.velero.metadata[0].name

  values = [
    templatefile("${path.module}/files/values.yaml.tpl", {
      cluster_name = var.cluster_name
      region       = var.region
    })
  ]

}
