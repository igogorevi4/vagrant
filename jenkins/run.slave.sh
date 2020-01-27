#/usr/bin/env bash

echo "----- Intallation Java"
apt-get update
apt-get install -y openjdk-8-jdk

echo "----- Timezone is being set up to Europe/Moscow"
timedatectl set-timezone Europe/Moscow

echo "----- Creating and configuring jenkins user"
useradd --system -U -d /var/lib/jenkins -m -s /bin/bash jenkins
mkdir -p /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
chown jenkins:jenkins /var/lib/jenkins/.ssh

echo "----- Writing Jenkins IPs to /etc/hosts"
cat >> /etc/hosts <<EOF
# jenkins servers
192.168.50.4      jenkins-master
192.168.50.5      jenkins-slave
EOF
