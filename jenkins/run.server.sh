#/usr/bin/env bash
    
# apt-get update -y
# apt-get upgrade -y

echo "__________ Setting Jenkins key for package manager __________"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "__________ Intallation Java & Jenkins __________"
apt-get update
# apt-get install -y openjdk-8-jre
apt-get install -y openjdk-8-jdk
apt-get install -y jenkins

echo "__________ Timezone is being set up to Europe/Moscow __________"
timedatectl set-timezone Europe/Moscow

echo "__________ Jenkins user ssh keys configuring __________"
mkdir -p /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
chown jenkins:jenkins /var/lib/jenkins/.ssh
touch /var/lib/jenkins/.ssh/id_rsa
echo $1 >> /var/lib/jenkins/.ssh/id_rsa
chown jenkins:jenkins /var/lib/jenkins/.ssh/id_rsa
chmod 600 /var/lib/jenkins/.ssh/id_rsa 

echo "__________ Writing Jenkins IPs to /etc/hosts __________"
cat >> /etc/hosts <<EOF
# jenkins servers
192.168.50.4      jenkins-master
192.168.50.5      jenkins-slave
EOF

echo "__________ Starting up Jenkins server __________"
systemctl start jenkins.service
systemctl enable jenkins.service

echo "__________ Waiting for Jenkins started __________"
sleep 1m

echo "__________ Getting initial password __________"
# JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
JENKINSPWD=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
echo "Go to your web-browser and put this password to finalize Jenkins installation: $JENKINSPWD "
