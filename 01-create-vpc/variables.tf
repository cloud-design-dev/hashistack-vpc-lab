variable "name" {
  description = ""
  type        = string
}

variable "resource_group" {
  description = "Name of the resource group to use for VPC resources."
  type        = string
}

variable "existing_ssh_key" {
  description = "Name of an existing SSH key in the VPC region. If none provided, one will be created and added to the VPC Region"
  type        = string
}

variable "allow_ssh_from" {
  description = ""
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  default = ["owner:ryantiffany"]
}

variable "region" {}
