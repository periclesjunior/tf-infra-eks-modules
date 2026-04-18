variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "public_subnet_1a" {
  type        = string
  description = "Subnet to create EKS cluster AZ 1a"
}

variable "public_subnet_1b" {
  type        = string
  description = "Subnet to create EKS cluster AZ 1b"
}

variable "cluster_version" {
  type        = string
  description = "EKS Cluster Version"
}

variable "endpoint_private_access" {
  type        = string
  description = "Endpoint private access"
}

variable "endpoint_public_access" {
  type        = string
  description = "Endpoint public access"
}

