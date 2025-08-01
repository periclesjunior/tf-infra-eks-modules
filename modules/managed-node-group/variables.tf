variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name to create MNG"
}

variable "private_subnet_1a" {
  type        = string
  description = "Subnet ID from AZ 1a"
}

variable "private_subnet_1b" {
  type        = string
  description = "Subnet ID from AZ 1b"
}
