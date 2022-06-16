resource "ibm_is_security_group" "frontend_security_group" {
  name           = "${var.name}-frontend-sg"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.region}", "project:${var.name}"])
}

resource "ibm_is_security_group_rule" "frontend_ssh_inbound" {
  group     = ibm_is_security_group.frontend_security_group.id
  direction = "inbound"
  remote    = var.allow_ssh_from
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "frontend_all_to_self" {
  group     = ibm_is_security_group.frontend_security_group.id
  direction = "inbound"
  remote    = ibm_is_security_group.frontend_security_group.id
}

resource "ibm_is_security_group_rule" "frontend_inbound_from_backend" {
  group     = ibm_is_security_group.frontend_security_group.id
  direction = "inbound"
  remote    = ibm_is_security_group.backend_security_group.id
}

resource "ibm_is_security_group_rule" "frontend_ping_inbound" {
  group     = ibm_is_security_group.frontend_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {}
}

resource "ibm_is_security_group_rule" "frontend_all_out" {
  group     = ibm_is_security_group.frontend_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_security_group" "backend_security_group" {
  name           = "${var.name}-backend-sg"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.region}", "project:${var.name}"])
}


resource "ibm_is_security_group_rule" "backend_ping_inbound_from_frontend" {
  group     = ibm_is_security_group.backend_security_group.id
  direction = "inbound"
  remote    = ibm_is_security_group.frontend_security_group.id
  icmp {
    type = 8
    code = 0
  }
}

resource "ibm_is_security_group_rule" "backend_ssh_from_frontend" {
  group     = ibm_is_security_group.backend_security_group.id
  direction = "inbound"
  remote    = ibm_is_security_group.frontend_security_group.id
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "backend_all_to_self" {
  group     = ibm_is_security_group.backend_security_group.id
  direction = "inbound"
  remote    = ibm_is_security_group.backend_security_group.id
}

resource "ibm_is_security_group_rule" "backend_all_out" {
  group     = ibm_is_security_group.backend_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}