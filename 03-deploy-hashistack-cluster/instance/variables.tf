variable "vpc_id" {}
variable "resource_group_id" {}
variable "name" {}
variable "ssh_key_ids" {}
variable "subnet_id" {}
variable "security_groups" {}
variable "zone" {}
variable "image_id" {}
variable "tags" {}
variable "allow_ip_spoofing" {
  default = false
}
