#!/bin/bash

NOMAD_USER_TOKEN_FILENAME="nomad.token"
LB_ADDRESS=$(terraform output -raw lb_address_consul_nomad)
CONSUL_BOOTSTRAP_TOKEN=$(terraform output -raw consul_bootstrap_token_secret)

# Get nomad user token from consul kv
NOMAD_TOKEN=$(curl -s --header "Authorization: Bearer ${CONSUL_BOOTSTRAP_TOKEN}" "${LB_ADDRESS}:8500/v1/kv/nomad_user_token?raw")

# Save token to file if file doesn't already exist
if [ ! -f $NOMAD_USER_TOKEN_FILENAME ]; then
    echo $NOMAD_TOKEN > $NOMAD_USER_TOKEN_FILENAME

    # Check length of token to see if retrieval worked before deleting from KV
    if [ ${#NOMAD_TOKEN} -eq 36 ]; then
        # Delete nomad user token from consul kv
        DELETE_TOKEN=$(curl -s -X DELETE --header "Authorization: Bearer ${CONSUL_BOOTSTRAP_TOKEN}" "${LB_ADDRESS}:8500/v1/kv/nomad_user_token")

        echo -e "\nThe Nomad user token has been saved locally to $NOMAD_USER_TOKEN_FILENAME and deleted from the Consul KV store."

        echo -e "\nSet the following environment variables to access your Nomad cluster with the user token created during setup:\n\nexport NOMAD_ADDR=\$(terraform output -raw lb_address_consul_nomad):4646\nexport NOMAD_TOKEN=\$(cat $NOMAD_USER_TOKEN_FILENAME)\n"

        echo -e "\nThe Nomad UI can be accessed at ${LB_ADDRESS}:4646/ui\nwith the bootstrap token: $(cat $NOMAD_USER_TOKEN_FILENAME)"
        
    else
        echo -e "\nSomething went wrong when retrieving the token from the Consul KV store.\nCheck the nomad.token file or wait a bit and then try running the script again.\n\nNOT deleting token from KV."
    fi
    
else 
    echo -e "\n***\nThe $NOMAD_USER_TOKEN_FILENAME file already exists - not overwriting. If this is a new run, delete it first.\n***"
fi

VAULT_PRIMARY="http://13.40.199.164"

# initializing Vault
echo "initializing Vault"
RAW_INIT=$(curl \
    --request POST \
    --data @payload.json \
    $VAULT_PRIMARY:8200/v1/sys/init)
touch vault.init
echo "VAULT_UNSEAL_KEY=`echo $RAW_INIT | jq .keys | jq .'[0]'`" >> vault.init
echo "VAULT_TOKEN=`echo $RAW_INIT | jq .root_token`" >> vault.init
export CONSUL_HTTP_ADDR=$LB_ADDRESS:8500
export CONSUL_HTTP_TOKEN=$CONSUL_BOOTSTRAP_TOKEN
echo "VAULT_CONSUL_ACL_TOKEN=`consul acl token create -policy-name=vault-server  -format=json | jq .SecretID`" >> vault.init
echo "VAULT_PRIMARY_ADDR=$VAULT_PRIMARY:8200" >> vault.init