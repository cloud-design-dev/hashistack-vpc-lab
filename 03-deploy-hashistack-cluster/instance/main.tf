resource "ibm_is_instance" "instance" {
  name                     = var.name
  image                    = var.image_id
  profile                  = "cx2-2x4"
  metadata_service_enabled = true
  resource_group           = var.resource_group_id

  boot_volume {
    name = "${var.name}-boot"
  }

  primary_network_interface {
    subnet            = var.subnet_id
    security_groups   = var.security_groups
    allow_ip_spoofing = var.allow_ip_spoofing
  }

  vpc  = var.vpc_id
  zone = var.zone
  keys = [var.ssh_key_ids]
  tags = concat(var.tags, ["type:is_instance"])
}
