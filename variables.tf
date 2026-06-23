variable "cidr_block" {
  description = "Networking CIDR block to be used for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of VPC Public Subnets"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "List of VPC Private Subnets"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}

variable "project_name" {
  description = "Project name to be used to name the resources (Name tag)"
  type        = string
}

variable "region" {
  description = "AWS region to create the resources"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "A map of tags to add to all AWS resources"
  type        = map(any)
}

variable "auto_scale_options" {
  description = "Cluster Autoscaling Settings"
  type = object({
    min     = number
    max     = number
    desired = number
  })
  default = {
    min     = 1
    max     = 1
    desired = 1
  }
}

variable "ami_type" {
  description = "AMI type"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "instance_types" {
  description = "Instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "Capacity type"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Disk size"
  type        = string
  default     = "100"
}

variable "max_pods" {
  description = "Maximum number of pods per node for AL2023 mng"
  type        = number
  default     = 110
}

variable "cluster_version" {
  description = "Cluster Version"
  type        = string
  default     = "1.35"
}

variable "endpoint_private_access" {
  description = "Endpoint private access"
  type        = string
  default     = "true"
}

variable "endpoint_public_access" {
  description = "Endpoint public access"
  type        = string
  default     = "true"
}

variable "access_entries" {
  description = "Map of IAM principals to grant access to the EKS cluster"
  type = map(object({
    principal_arn     = string
    type              = optional(string, "STANDARD")
    kubernetes_groups = optional(list(string))
    policy_associations = optional(map(object({
      policy_arn = string
      access_scope = object({
        type       = string
        namespaces = optional(list(string), [])
      })
    })), {})
  }))
  default = {}
}

variable "addon_coredns_version" {
  description = "CoreDNS addon version"
  type        = string

}

variable "addon_kubeproxy_version" {
  description = "Kube-Proxy addon version"
  type        = string
}

variable "addon_cni_version" {
  description = "VPC CNI addon version"
  type        = string
}

variable "addon_ebs_csi_version" {
  description = "EBS CSI addon version"
  type        = string
}

variable "service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes pod and service IP addresses "
  type        = string
}
