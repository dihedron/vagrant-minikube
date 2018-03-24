#!/usr/bin/env bash

KVM_DRIVER_VERSION=v0.10.0
MINIKUBE_VERSION=v0.25.2

#
# INSTALL PREREQUISITES (CURL AND LIBVIRT/KVM)
#
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y curl qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

#
# HACK: CHANGE OWNERSHIP OF LIBVIRT
#
sudo chown vagrant /var/run/libvirt

#
# DOWNLOAD AND INSTALL KUBECTL
#
echo -n "downloading and installing kubectl..."
curl -LsO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && sudo mv kubectl /usr/local/bin/ && sudo chmod 755 /usr/local/bin/kubectl
echo "DONE!"

#
# DOWNLOAD AND INSTALL MINIKUBE
#
echo -n "downloading and installing minikube..."
curl -Lso minikube https://storage.googleapis.com/minikube/releases/${MINIKUBE_VERSION}/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/ && sudo chmod 755 /usr/local/bin/minikube
echo "DONE!"

#
# CONFIGURE VAGRANT USER TO LOAD KVM/KVM2 DRIVERS 
#
echo -n "configuring user rights..."
sudo usermod -a -G libvirtd vagrant
newgrp libvirtd
echo "DONE!"

echo "user $(whoami) belongs to $(groups)"

#
# DOWNLOAD INSTALL AND CONFIGURE KVM2 DRIVER
#
echo -n "downloading and installing KVM2 driver..."
curl -LsO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 && sudo mv docker-machine-driver-kvm2 /usr/local/bin/ && sudo chmod 755 /usr/local/bin/docker-machine-driver-kvm2
echo "DONE!"

#
# DOWNLOAD INSTALL AND CONFIGURE KVM DRIVER
#
echo -n "downloading and installing KVM driver..."
curl -Lso docker-machine-driver-kvm https://github.com/dhiltgen/docker-machine-kvm/releases/download/${KVM_DRIVER_VERSION}/docker-machine-driver-kvm-ubuntu16.04 && sudo mv docker-machine-driver-kvm /usr/local/bin/ && sudo chmod 755 /usr/local/bin/docker-machine-driver-kvm
echo "DONE!"

echo "You can now run 'minikube start --vm-driver [kvm|kvm2]'"
