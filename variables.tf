variable "cidr_block" {
  description = "Networking CIDR block to be used for the VPC"
  type        = string
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
