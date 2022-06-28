resource "ibm_is_security_group" "services_security_group" {
  name           = "${var.name}-services-sg"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.region}", "project:${var.name}"])
}

resource "ibm_is_security_group_rule" "services_to_self" {
  group     = ibm_is_security_group.services_security_group.id
  direction = "inbound"
  remote    = ibm_is_security_group.services_security_group.id
}

resource "ibm_is_security_group_rule" "services_ping_inbound" {
  group     = ibm_is_security_group.services_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
    code = 0
  }
}

resource "ibm_is_security_group_rule" "services_all_out" {
  group     = ibm_is_security_group.services_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}
