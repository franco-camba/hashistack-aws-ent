#!/bin/bash
UNSEAL_KEY="UNSEAL_KEY"
VAULT_CONSUL_ACL_TOKEN="VAULT_CONSUL_ACL_TOKEN"
export VAULT_ADDR="http://127.0.0.1:8200"
echo "Providing Vault with Consul ACL token"
sed -i "s/CONSUL_ACL_TOKEN/$VAULT_CONSUL_TOKEN/g" /etc/vault.d/vault.hcl
echo "Restarting Vault service"
sudo systemctl restart vault
sleep 15
echo "Unsealing Vault - If errored, retry the command"
vault operator unseal $UNSEAL_KEY
