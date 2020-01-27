#/usr/bin/env bash

# Generate ssh key pair for Jenkins 
ssh-keygen -b 4096 -t rsa -f tmp_id_rsa -q -N ""

vagrant up

# removimng temporary ssh keys files
rm tmp_id_rsa tmp_id_rsa.pub