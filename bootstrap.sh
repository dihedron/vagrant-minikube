#!/usr/bin/env bash

MINIKUBE_VERSION=v0.25.2

echo "running as $(whoami)..."

#
# UPDATE SYSTEM AND INSTALL BASE PACKAGES
#
apt-get update -y
apt-get dist-upgrade -y
apt-get install -y curl apt-transport-https ca-certificates software-properties-common

#
# INSTALL PREREQUISITES (DOCKER CE)
#
echo -n "installing docker ce..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce
groupadd docker
usermod -aG docker vagrant
newgrp docker
echo "DONE!"

echo "user vagrant belongs to $(groups vagrant)"

#
# DOWNLOAD AND INSTALL KUBECTL
#
echo -n "downloading and installing kubectl..."
curl -LsO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && mv kubectl /usr/local/bin/ && chmod 755 /usr/local/bin/kubectl
echo "DONE!"

#
# DOWNLOAD AND INSTALL MINIKUBE
#
echo -n "downloading and installing minikube..."
curl -Lso minikube https://storage.googleapis.com/minikube/releases/${MINIKUBE_VERSION}/minikube-linux-amd64 && mv minikube /usr/local/bin/ && chmod 755 /usr/local/bin/minikube
minikube start --vm-driver none
echo "DONE!"

#echo -n "installing minikube as daemon..."
#cp /vagrant/minikube.service /etc/systemd/system/
#cp /vagrant/minikube.sh /usr/local/bin && chmod 755 /usr/local/bin/minikube.sh 
#systemctl daemon-reload
#systemctl enable minikube.service
#systemctl start minikube.service
#echo "DONE!"

#echo "You can now run 'sudo minikube start --vm-driver none'"
