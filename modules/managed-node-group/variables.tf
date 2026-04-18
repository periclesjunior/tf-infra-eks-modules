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

variable "private_subnet_1a" {
  description = "Subnet ID from AZ 1a"
  type        = string
}

variable "private_subnet_1b" {
  type        = string
  description = "Subnet ID from AZ 1b"
}

variable "auto_scale_options" {
  description = "Cluster Autoscaling Settings"
  type = object({
    min     = number
    max     = number
    desired = number
  })
}

variable "ami_type" {
  description = "AMI type"
  type        = string
}

variable "instance_types" {
  description = "Instance types"
  type        = list(string)
}

variable "capacity_type" {
  description = "Capacity type"
  type        = string
}

variable "disk_size" {
  description = "Disk size"
  type        = string
}
