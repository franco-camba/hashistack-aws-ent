# Set up a Hashistack cluster (Vault-Nomad-Consul) on AWS EC2 using Packer and Terraform

This repo is small tweak of a companion to the [Cluster Setup](https://developer.hashicorp.com/nomad/tutorials/cluster-setup) collection of tutorials, containing configuration files to create a Nomad/Consul/Vault cluster with ACLs enabled on AWS using Enterprise Binaries.

## Prerequisites
On top of the prerequisites defined here: https://developer.hashicorp.com/nomad/tutorials/cluster-setup
You need to obtain a Nomad, Consul and Vault license in order for this deployment to work.
This deployment is based on Enterprise binaries and will not work without a valid license for the 3 products.

## Enterprise Binaries
Located here: https://releases.hashicorp.com/
Consul -> https://releases.hashicorp.com/consul/1.14.4+ent/consul_1.14.4+ent_linux_amd64.zip
Vault -> https://releases.hashicorp.com/vault/1.12.3+ent/vault_1.12.3+ent_linux_amd64.zip
Nomad -> https://releases.hashicorp.com/nomad/1.4.3+ent/nomad_1.4.3+ent_linux_amd64.zip