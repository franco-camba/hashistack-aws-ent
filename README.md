# Set up a Hashistack cluster (Vault-Nomad-Consul) on AWS EC2 using Packer and Terraform

This repo is small tweak of a companion to the [Cluster Setup](https://developer.hashicorp.com/nomad/tutorials/cluster-setup) collection of tutorials, containing configuration files to create a Nomad/Consul/Vault cluster with ACLs enabled on AWS using Enterprise Binaries.

## Prerequisites
On top of the prerequisites defined here: https://developer.hashicorp.com/nomad/tutorials/cluster-setup
You need to obtain a Nomad, Consul and Vault license in order for this deployment to work.
This deployment is based on Enterprise binaries and will not work without a valid license for the 3 products.