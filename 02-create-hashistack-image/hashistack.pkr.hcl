packer {
  required_plugins {
    ibmcloud = {
      version = ">=v2.2.0"
      source  = "github.com/IBM/ibmcloud"
    }
  }
}

variable "ibmcloud_api_key" {
  type    = string
}

variable "ibm_region" {
  type = string
}

variable "resource_group_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  name      = "hashi-${local.timestamp}"
}

source "ibmcloud-vpc" "hashi_base_image" {
  api_key = "${var.ibmcloud_api_key}"
  region  = "${var.ibm_region}"

  subnet_id          = "${var.subnet_id}"
  resource_group_id  = "${var.resource_group_id}"
  security_group_id  = ""
  vsi_base_image_id  = "r006-dd164da8-c4d9-46ba-87c4-03c614f0532c"
  vsi_profile        = "cx2-2x4"
  vsi_interface      = "public"
  vsi_user_data_file = ""

  image_name = "${local.name}"

  communicator = "ssh"
  ssh_username = "root"
  ssh_port     = 22
  ssh_timeout  = "15m"

  timeout = "30m"
}

build {
  sources = [
    "source.ibmcloud-vpc.hashi_base_image",
  ]

  provisioner "file" {
    source      = "./installer.sh"
    destination = "/opt/installer.sh"
  }

  provisioner "shell" {
    execute_command = "{{.Vars}} bash '{{.Path}}'"
    inline = [
      "chmod +x /opt/installer.sh",
      "/opt/installer.sh"
    ]
  }

  post-processor "manifest" {
    output     = "../shared-data/manifest.json"
    strip_path = true
  }
}
