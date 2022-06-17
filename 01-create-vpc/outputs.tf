resource "local_file" "terraform_variables" {
  content = templatefile("../templates/tfvars.tmpl",
    {
      vpc_id                  = ibm_is_vpc.vpc.id
      resource_group_id       = data.ibm_resource_group.group.id
      name                    = "${var.name}"
      ssh_key_id              = data.ibm_is_ssh_key.region.id
      frontend_subnet_id      = "${ibm_is_subnet.frontend_subnet.id}"
      backend_subnet_id       = "${ibm_is_subnet.backend_subnet.id}"
      frontend_security_group = "${ibm_is_security_group.frontend_security_group.id}"
      backend_security_group  = "${ibm_is_security_group.backend_security_group.id}"
    }
  )
  filename = "../shared-data/terraform.tfvars"
}


resource "local_file" "packer_variables" {
  content = templatefile("../templates/pkrvars.tmpl",
    {
      resource_group_id = "${data.ibm_resource_group.group.id}"
      subnet_id         = "${ibm_is_subnet.backend_subnet.id}"
      ibm_region        = "${var.region}"
    }
  )
  filename = "../shared-data/.pkrvars.hcl"
}


