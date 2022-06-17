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
  total_ipv4_address_count = "64"
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

resource "ibm_is_floating_ip" "bastion_ip" {
  name           = "${var.name}-bastion-ip"
  resource_group = data.ibm_resource_group.group.id
  zone           = data.ibm_is_zones.region.zones[0]
  tags           = concat(var.tags, ["region:${var.region}", "zone:${data.ibm_is_zones.region.zones[0]}", "project:${var.name}"])
}