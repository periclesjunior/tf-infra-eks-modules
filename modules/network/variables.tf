variable "cidr_block" {
  description = "Networking CIDR block to be used for the VPC"
  type        = string
}

variable "project_name" {
  description = "Project name to be used to name the resources (Name tag)"
  type        = string
}

variable "tags" {
  description = "Tags to be added to AWS resources"
  type        = map(any)
}
