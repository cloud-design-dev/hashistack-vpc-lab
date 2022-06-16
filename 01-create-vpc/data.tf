data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_is_zones" "region" {
  region = var.region
}

data "ibm_is_ssh_key" "existing_ssh_key" {
  count = var.existing_ssh_key != "" ? 1 : 0
  name  = var.existing_ssh_key
}
