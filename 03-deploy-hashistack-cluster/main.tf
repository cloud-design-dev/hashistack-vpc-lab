module "instance" {
  count             = var.instance_count
  source            = "./instance"
  name              = "${var.name}-${count.index + 1}"
  resource_group_id = var.resource_group_id
  image_id          = jsondecode(data.local_file.packer_manifest.content)["builds"][0]["artifact_id"]
  vpc_id            = var.vpc_id
  zone              = var.zone
  subnet_id         = var.backend_subnet_id
  security_groups   = ["${var.services_security_group}", "${var.bastion_maintenance_security_group}"]
  ssh_key_ids       = var.ssh_key_ids
  tags              = concat(var.tags, ["region:${var.region}", "zone:${var.zone}", "vpc:${var.name}-vpc"])
}

#module "ansible" {xc
#  source      = "./ansible"
#  instances   = module.instance[*].instance
#  bastion_ip  = module.bastion.bastion_public_ip
#  datacenter  = data.ibm_is_zones.mzr.zones[0]
#  encrypt_key = var.encrypt_key
#}
