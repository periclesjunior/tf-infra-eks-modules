variable "project_name" {
  description = "Project name to be used to name the resources (Name tag)"
  type        = string
}

variable "tags" {
  description = "Tags to be added to AWS resources"
  type        = map(any)
}

variable "cluster_name" {
  description = "EKS cluster name to create MNG"
  type        = string
}

variable "oidc" {
  description = "HTTPS URL from OIDC provider of the EKS cluster"
  type        = string
}

variable "addon_coredns_version" {
  description = "CoreDNS addon version"
  type        = string
  default     = "v1.14.2-eksbuild.4"
}

variable "addon_kubeproxy_version" {
  description = "Kube-Proxy addon version"
  type        = string
  default     = "v1.35.3-eksbuild.5"
}

variable "addon_cni_version" {
  description = "VPC CNI addon version"
  type        = string
  default     = "v1.21.1-eksbuild.8"
}

variable "addon_ebs_csi_version" {
  description = "EBS CSI addon version"
  type        = string
}
