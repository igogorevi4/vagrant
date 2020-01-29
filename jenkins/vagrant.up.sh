#/usr/bin/env bash

# Generate ssh key pair for Jenkins 
ssh-keygen -b 4096 -t rsa -f tmp_id_rsa -q -N ""

vagrant up > vagrant.up.log

JENKINS_PASSWORD=$(grep "JenkinsPassword" vagrant.up.log | awk '{print $NF}')
echo "Go to your web-browser and put this password to finalize Jenkins installation: $JENKINS_PASSWORD"

# removimng temporary ssh keys files
rm tmp_id_rsa tmp_id_rsa.pub