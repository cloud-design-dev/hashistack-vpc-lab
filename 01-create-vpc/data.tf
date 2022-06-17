data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_is_zones" "region" {
  region = var.region
}

data "ibm_is_ssh_key" "region" {
  name = var.ssh_key
}
