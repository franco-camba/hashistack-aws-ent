# Set up a Hashistack cluster (Vault-Nomad-Consul) on AWS EC2 using Packer and Terraform

This repo is small tweak of a companion to the [Cluster Setup](https://developer.hashicorp.com/nomad/tutorials/cluster-setup) collection of tutorials, containing configuration files to create a Nomad/Consul/Vault cluster with ACLs enabled on AWS using Enterprise Binaries.

## Prerequisites
On top of the prerequisites defined here: https://developer.hashicorp.com/nomad/tutorials/cluster-setup
You need to obtain a Nomad, Consul and Vault license in order for this deployment to work.
This deployment is based on Enterprise binaries and will not work without a valid license for the 3 products.

## Enterprise Binaries
Enterprise Binaries are automatically downloaded by the provided scripts.
Current versions in use are below with their download link provided just in case you need to download/locate them:
Main Hashicorp release url: https://releases.hashicorp.com/
Consul -> https://releases.hashicorp.com/consul/1.14.4+ent/consul_1.14.4+ent_linux_amd64.zip
Vault -> https://releases.hashicorp.com/vault/1.12.3+ent/vault_1.12.3+ent_linux_amd64.zip
Nomad -> https://releases.hashicorp.com/nomad/1.4.3+ent/nomad_1.4.3+ent_linux_amd64.zip

# How to deploy the Hashistack
## 1.Clone the Repo
## 2.Add the license keys for Consul, Vault and Nomad within the /shared/config folder
## 3.Within the AWS folder, create your own variables.hcl with your own values (example is provided)
## 4.Run Packer to build the hashistack VM image. 
Within the aws folder run: packer build -var-file=variables.hcl image.pkr.hcl
## 5.Copy the created AMI id from packer to the variables.hcl
## 6.Execute Terraform 
terraform apply -variable-file=variables.hcl

# Verify that your installation went through successfully
WIP section