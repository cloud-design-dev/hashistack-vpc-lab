resource "local_file" "terraform_variables" {
  content = templatefile("../templates/tfvars.tftpl",
    {
      vpc_id                             = ibm_is_vpc.vpc.id
      resource_group_id                  = data.ibm_resource_group.group.id
      name                               = "${var.name}"
      ssh_key_id                         = data.ibm_is_ssh_key.region.id
      backend_subnet_id                  = "${ibm_is_subnet.backend_subnet.id}"
      bastion_maintenance_security_group = "${module.bastion.bastion_maintenance_group_id}"
      services_security_group            = "${ibm_is_security_group.services_security_group.id}"
      zone                               = "${data.ibm_is_zones.region.zones[0]}"
      region                             = "${var.region}"
      bastion_ip                         = "${module.bastion.bastion_public_ip}"
      encrypt_key                        = var.encrypt_key
      tags                               = "project:ibmcloud-hashistack"
    }
  )
  filename = "../shared-data/terraform.tfvars"
}


resource "local_file" "packer_variables" {
  content = templatefile("../templates/pkrvars.tftpl",
    {
      resource_group_id = "${data.ibm_resource_group.group.id}"
      subnet_id         = "${ibm_is_subnet.backend_subnet.id}"
      ibm_region        = "${var.region}"
    }
  )
  filename = "../shared-data/.pkrvars.hcl"
}


