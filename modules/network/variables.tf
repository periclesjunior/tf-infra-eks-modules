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

variable "public_subnets" {
  description = "List of VPC Public Subnets"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "List of VPC Private Subnets"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}
