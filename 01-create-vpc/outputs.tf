resource "local_file" "environment_info" {
  content = jsonencode({
    "vpc_id"     = "${ibm_is_vpc.vpc.id}",
    "bastion_sg" = "${ibm_is_security_group.frontend_security_group.id}",
    "subnet_id"  = "${ibm_is_subnet.backend_subnet.id}"
  })
  filename = "../shared-data/env_info.json"
}


resource "local_file" "packer_variables" {
  content = templatefile("../02-create-hashistack-image/pkrvars.tmpl",
    {
      resource_group_id = "${data.ibm_resource_group.group.id}"
      subnet_id         = "${ibm_is_subnet.backend_subnet.id}"
      ibm_region        = "${var.region}"
    }
  )
  filename = "../shared-data/.pkrvars.hcl"
}
