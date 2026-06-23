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

variable "subnet_ids" {
  description = "Lits subnets ids"
  type        = list(string)
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

variable "max_pods" {
  description = "Maximum number of pods per node configured through AL2023 nodeadm kubelet config."
  type        = number
  default     = 110
}
