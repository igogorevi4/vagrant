#/usr/bin/env bash

# Generate ssh key pair for Jenkins 
ssh-keygen -b 4096 -t rsa -f tmp_id_rsa -q -N ""
export SSH_PRIVATE_KEY=$(cat tmp_id_rsa)
export SSH_PUBLIC_KEY=$(cat tmp_id_rsa.pub)
rm tmp_id_rsa tmp_id_rsa.pub

# echo "$SSH_PRIVATE_KEY $SSH_PUBLIC_KEY"
# vagrant up --arg$SSH_PRIVATE_KEY --arg$SSH_PUBLIC_KEY
vagrant up