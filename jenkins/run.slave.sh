#/usr/bin/env bash
    
# apt-get update -y
# apt-get upgrade -y

# echo "__________ Setting Jenkins key for package manager __________"
# wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
# sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "__________ Intallation Java __________"
apt-get update
apt-get install -y openjdk-8-jdk

echo "__________ Timezone is being set up to Europe/Moscow __________"
timedatectl set-timezone Europe/Moscow

echo "__________ Creating and configuring jenkins user __________"
useradd --system -U -d /var/lib/jenkins -m -s /bin/bash jenkins
mkdir -p /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
chown jenkins:jenkins /var/lib/jenkins/.ssh
touch /var/lib/jenkins/.ssh/authorized_keys
echo $1 >> /var/lib/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /var/lib/jenkins/.ssh/authorized_keys
chmod -R 600 /var/lib/jenkins/.ssh/authorized_keys 

echo "__________ Allowing Jenkins from jenkins-master IP __________" 
sshd_config AllowUsers jenkins@192.168.50.4

echo "__________ Writing Jenkins IPs to /etc/hosts __________"
cat >> /etc/hosts <<EOF
# jenkins servers
192.168.50.4      jenkins-master
192.168.50.5      jenkins-slave
EOF

# copy the id_rsa.pub from jenkins master to jenkins slave authorized keys (do manually for now)
# vi /var/lib/jenkins-slave/.ssh/authorized_keys
#   copy jenkinsmasterhost:/var/lib/jenkins/ssh/id_rsa.pub