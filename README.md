# hashistack-vpc-lab

Using Packer, Terraform, and Ansible to deploy a Hashistack Cluster in IBM Cloud VPC

- [Packer](https://www.packer.io): Build a `near-golden` image with a suite of Hashicorp tools installed (Consul, Vault, Nomad, Consul-template)
- [Terraform](https://www.terraform.io): Create IBM Cloud VPC and deploy custom Packer Image in to 3 node cluster 
- [Ansible](https://www.ansible.com): Push Consul, Nomad, Vault configs to cluster nodes 

## Prerequisites

- IBM Cloud [API Key]() 
- [Packer](https://www.packer.io/downloads), [Terraform](https://www.terraform.io/downloads), and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html), installed. 

## Create base VPC using Terraform 

1. Clone the repository and change to `01-create-vpc` directory

```sh
git clone https://github.com/cloud-design-dev/hashistack-vpc-lab.git
cd hashistack-vpc-lab/01-create-vpc
```
    
1. Copy `terraform.tfvars.example` to `terraform.tfvars`:

   ```sh
   cp terraform.tfvars.example terraform.tfvars
   ```

1. Edit `terraform.tfvars` to match your environment. See [inputs](#inputs) for available options.

1. Plan deployment:

   ```sh
   terraform init
   terraform plan -out default.tfplan
   ```

1. Apply deployment:

   ```sh
   terraform apply default.tfplan
   ```
   
## Inputs

### Required Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ibmcloud\_api\_key | IBM Cloud API key used to deploy resources. | `string` | n/a | yes |
| name | Name that will be prepended to all deployed resources. | `string` | n/a | yes |
| region | IBM Cloud VPC region for deployed resources. | `string` | n/a | yes |
| allow\_ssh\_from | An IP address or CIDR that will be allowed to SSH in to bastion host. | `string` | `0.0.0.0/0` | yes |
| existing\_ssh\_key | Name of an existing SSH key in the VPC region. If none provided, one will be generated and added to the compute instances. | `string` | n/a | no |


