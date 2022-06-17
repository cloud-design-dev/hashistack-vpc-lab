module "bastion" {
  source = "./instance"

  vpc_id            = var.vpc_id
  resource_group_id = var.resource_group_id
  name              = "${var.name}-bastion"
  ssh_key_id      = var.ssh_key_id
  subnet_id         = var.frontend_subnet_id
}