ui = true
license_path = "/etc/vault.d/vault.hclic"
backend "consul" {
  path          = "vault/"
  address       = "IP_ADDRESS:8500"
  cluster_addr  = "https://IP_ADDRESS:8201"
  redirect_addr = "http://IP_ADDRESS:8200"
  token = CONSUL_ACL_TOKEN
}

listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "IP_ADDRESS:8201"
  tls_disable     = 1
}
