#/usr/bin/env bash

echo "----- Setting Jenkins key for package manager"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "----- Intallation Java & Jenkins"
apt-get update
apt-get install -y openjdk-8-jdk
apt-get install -y jenkins

echo "----- Timezone is being set up to Europe/Moscow"
timedatectl set-timezone Europe/Moscow

echo "----- Jenkins user ssh keys configuring"
mkdir -p /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
chown jenkins:jenkins /var/lib/jenkins/.ssh

echo "----- Writing Jenkins IPs to /etc/hosts"
cat >> /etc/hosts <<EOF
# jenkins servers
192.168.50.4      jenkins-master
192.168.50.5      jenkins-slave
EOF
