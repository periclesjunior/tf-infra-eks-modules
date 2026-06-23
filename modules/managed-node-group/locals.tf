locals {
  nodeadm_user_data = <<-EOT
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: application/node.eks.aws

---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    name: ${var.cluster_name}
    apiServerEndpoint: ${data.aws_eks_cluster.this.endpoint}
    certificateAuthority: ${data.aws_eks_cluster.this.certificate_authority[0].data}
    cidr: ${data.aws_eks_cluster.this.kubernetes_network_config[0].service_ipv4_cidr}
  kubelet:
    config:
      maxPods: ${var.max_pods}

--//--
EOT
}
