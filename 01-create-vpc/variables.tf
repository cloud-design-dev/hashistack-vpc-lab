variable "name" {
  description = "Name that will be prepended to all deployed resources."
  type        = string
}

variable "resource_group" {
  description = "Name of the resource group to use for VPC resources."
  type        = string
}

variable "ssh_key" {
  description = "Name of an existing SSH key in the VPC region."
  type        = string
}

variable "allow_ssh_from" {
  description = "An IP address or CIDR range to allow inbound SSH connections to the frontend (bastion) host."
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  default = ["project:ibmcloud-hashistack"]
}

variable "region" {
  description = "The IBM Cloud Region where the VPC and associated resources will be deployed."
  type        = string
}

variable "ibmcloud_api_key" {
  description = "The API key for the IBM Cloud account."
  type        = string
}

variable "encrypt_key" {
  description = "The encryption key used for consul gossip protocol."
  type        = string
}
