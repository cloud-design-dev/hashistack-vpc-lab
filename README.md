# hashistack-vpc-lab

Using Packer, Terraform, and Ansible to deploy a Hashistack Cluster in IBM Cloud VPC

- [Packer](https://www.packer.io): Build a `near-golden` image with a suite of Hashicorp tools installed (Consul, Vault, Nomad, Consul-template)
- [Terraform](https://www.terraform.io): Create IBM Cloud VPC and deploy custom Packer Image in to 3 node cluster 
- [Ansible](https://www.ansible.com): Push Consul, Nomad, Vault configs to cluster nodes 

## Pre-requisites

- IBM Cloud [API Key]() 
- [Packer](https://www.packer.io/downloads), [Terraform](https://www.terraform.io/downloads), and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html), installed. 
