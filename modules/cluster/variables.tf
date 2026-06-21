variable "project_name" {
  description = "Project name to be used to name the resources (Name tag)"
  type        = string
}

variable "tags" {
  description = "Tags to be added to AWS resources"
  type        = map(any)
}

variable "subnet_ids" {
  description = "Lits subnets ids"
  type        = list(string)
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  type        = string
}

variable "endpoint_private_access" {
  description = "Endpoint private access"
  type        = string
}

variable "endpoint_public_access" {
  description = "Endpoint public access"
  type        = string
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

variable "service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes pod and service IP addresses "
  type        = string
}
