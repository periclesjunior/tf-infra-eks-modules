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

variable "auto_scale_options" {
  type = object({
    min     = number
    max     = number
    desired = number
  })
  description = "Cluster Autoscaling Settings"
}

variable "ami_type" {
  type        = string
  description = "AMI type"
}

variable "instance_types" {
  type        = list(string)
  description = "Instance types"
}

variable "capacity_type" {
  type        = string
  description = "Capacity type"
}
