variable "project_name" {
  description = "Project name used in resource names and tags."
  type        = string
}

variable "tags" {
  description = "Common tags added to node group resources."
  type        = map(any)
  default     = {}
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs used by all managed node groups."
  type        = list(string)
}

variable "node_groups" {
  description = "Map of managed node group definitions."

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

}
