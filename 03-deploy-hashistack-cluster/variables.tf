variable "vpc_id" {}
variable "resource_group_id" {}
variable "name" {}
variable "ssh_key_ids" {}
variable "backend_subnet_id" {}
variable "frontend_subnet_id" {}
variable "bastion_maintenance_security_group" {}
variable "services_security_group" {}
variable "instance_count" {
  default = 3
}
variable "zone" {}
variable "tags" {}
variable "region" {}
