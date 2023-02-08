data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"
license_path = "/etc/nomad.d"
# Enable the server
server {
  enabled          = true
  bootstrap_expect = SERVER_COUNT
}

consul {
  address = "127.0.0.1:8500"
  token = "CONSUL_TOKEN"
}

acl {
  enabled = true
}

vault {
  enabled          = false
  address          = "http://active.vault.service.consul:8200"
  task_token_ttl   = "1h"
  create_from_role = "nomad-cluster"
  token            = ""
}