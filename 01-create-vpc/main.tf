locals {
  ssh_key_ids = var.existing_ssh_key != "" ? [data.ibm_is_ssh_key.existing_ssh_key.0.id, ibm_is_ssh_key.generated_key.id] : [ibm_is_ssh_key.generated_key.id]
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "ibm_is_ssh_key" "generated_key" {
  name           = "${var.name}-${var.region}-key"
  public_key     = tls_private_key.ssh.public_key_openssh
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.region}", "zone:${data.ibm_is_zones.region.zones[0]}", "project:${var.name}"])
}


resource "ibm_is_vpc" "vpc" {
  name           = "${var.name}-vpc"
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.region}", "zone:${data.ibm_is_zones.region.zones[0]}", "project:${var.name}"])
}

resource "ibm_is_public_gateway" "frontend" {
  name           = "${var.name}-frontend-pubgw"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.region.zones[0]
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.region}", "zone:${data.ibm_is_zones.region.zones[0]}", "project:${var.name}"])
}

resource "ibm_is_subnet" "frontend_subnet" {
  name                     = "${var.name}-frontend-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.region.zones[0]
  total_ipv4_address_count = "128"
  resource_group           = data.ibm_resource_group.group.id
  public_gateway           = ibm_is_public_gateway.frontend.id
  tags                     = concat(var.tags, ["region:${var.region}", "zone:${data.ibm_is_zones.region.zones[0]}", "project:${var.name}"])
}

resource "ibm_is_subnet" "backend_subnet" {
  name                     = "${var.name}-backend-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.region.zones[0]
  total_ipv4_address_count = "256"
  resource_group           = data.ibm_resource_group.group.id
  tags                     = concat(var.tags, ["region:${var.region}", "zone:${data.ibm_is_zones.region.zones[0]}", "project:${var.name}"])
}