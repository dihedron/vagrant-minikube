#!/usr/bin/env bash

KUBECTL_VERSION=
MINIKUBE_VERSION=v0.25.2

#
# INSTALL PREREQUISITES (CURL AND LIBVIRT/KVM)
#
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y curl qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

#
# DOWNLOAD AND INSTALL KUBECTL
#
curl -LsO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && sudo mv kubectl /usr/local/bin/ && sudo chmod 755 /usr/local/bin/kubectl

#
# DOWNLOAD AND INSTALL MINIKUBE
#
curl -Lso minikube https://storage.googleapis.com/minikube/releases/${MINIKUBE_VERSION}/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/ && sudo chmod 755 /usr/local/bin/minikube
