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

variable "node_groups" {
  description = "Map of EKS managed node groups and their individual launch template, scaling, labels, taints and tags settings."

  type = map(object({
    min_size               = number
    max_size               = number
    desired_size           = number
    create_launch_template = optional(bool, true)
    launch_template_name   = optional(string)
    ami_type               = optional(string, "AL2023_x86_64_STANDARD")
    instance_types         = list(string)
    capacity_type          = optional(string, "ON_DEMAND")
    max_pods               = optional(number, 110)

    block_device_mappings = optional(map(object({
      device_name = string
      ebs = object({
        volume_size           = number
        volume_type           = optional(string, "gp3")
        iops                  = optional(number, 3000)
        throughput            = optional(number, 150)
        encrypted             = optional(bool, true)
        delete_on_termination = optional(bool, true)
        kms_key_id            = optional(string)
      })
    })), {})

    labels = optional(map(string), {})

    taints = optional(list(object({
      effect = string
      key    = string
      value  = optional(string)
    })), [])

    tags = optional(map(string), {})
  }))

  default = {}
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
