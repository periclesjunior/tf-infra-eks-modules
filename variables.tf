variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to create the resources"
}

variable "tags" {
  type        = map(any)
  description = "A map of tags to add to all AWS resources"
}

variable "auto_scale_options" {
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
  description = "Cluster Autoscaling Settings"
}

variable "ami_type" {
  type        = string
  default     = "AL2023_x86_64_STANDARD"
  description = "AMI type"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "Instance types"
}

variable "capacity_type" {
  type        = string
  default     = "ON_DEMAND"
  description = "Capacity type"
}

variable "disk_size" {
  type        = string
  default     = "100"
  description = "Disk size"
}

variable "cluster_version" {
  type        = string
  default     = "1.35"
  description = "Cluster Version"
}
