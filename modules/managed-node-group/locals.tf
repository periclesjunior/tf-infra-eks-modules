locals {
  launch_template_node_groups = {
    for name, group in var.node_groups : name => group
    if group.create_launch_template
  }

  nodeadm_user_data = {
    for name, group in local.launch_template_node_groups : name => <<-EOT
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
      maxPods: ${group.max_pods}

--//--
EOT
  }
}
