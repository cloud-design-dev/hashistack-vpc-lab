# hashistack-vpc-lab

Using Packer, Terraform, and Ansible to deploy a Hashistack Cluster in IBM Cloud VPC

- [Packer](https://www.packer.io): Build a `near-golden` image with a suite of Hashicorp tools installed (Consul, Vault, Nomad, Consul-template)
- [Terraform](https://www.terraform.io): Create IBM Cloud VPC and deploy custom Packer Image in to 3 node cluster 
- [Ansible](https://www.ansible.com): Push Consul, Nomad, Vault configs to cluster nodes 

## Prerequisites

- IBM Cloud [API Key](https://cloud.ibm.com/docs/account?topic=account-userapikey&interface=ui#manage-user-keys) 
- [Packer](https://www.packer.io/downloads), [Terraform](https://www.terraform.io/downloads), and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html), installed. 

## Steps

I've broken down the deployment in to 3 main steps, each in its own directory:

* Step 1: [Create base VPC](01-create-vpc/README.md)
    * Deploy a VPC, public gateway, a backend and frontend subnet, and some simple security groups.
    2. Generates a Packer variables file in the `shared-data` directory. (Used in Step 2)
    3. Generates a Terraform `tfvars` file in the `shared-data` directory. (Used in Step 3)

* Step 2: [Create Hashistack Packer Image](02-create-hashistack-image/README.md)
    * Validate Packer template file.
    2. Build custom image with Consul, Nomad, Vault, Consul-template installed.
    3. Generate a manifest file in the `shared-data` directory. The manifest file will be used as a data source for Step 3
