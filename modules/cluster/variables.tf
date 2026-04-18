variable "project_name" {
  description = "Project name to be used to name the resources (Name tag)"
  type        = string
}

variable "tags" {
  description = "Tags to be added to AWS resources"
  type        = map(any)
}

variable "public_subnet_1a" {
  description = "Subnet to create EKS cluster AZ 1a"
  type        = string
}

variable "public_subnet_1b" {
  description = "Subnet to create EKS cluster AZ 1b"
  type        = string
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
