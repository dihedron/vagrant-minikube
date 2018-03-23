# Vagrant minikube
Vagrant box with Minikube provisioning scripti for the VirtualBox provider.

## Usage
To start an Ubuntu 16.04.4 LTS "Xenial" virtual machine with ```minikube``` and ```kubectl```, simply run 
``` bash
vagrant up
```

## Notes
To let Vagrant check if Virtualbox Extensions are up to date and automatically update them if necessary, install the ```vbguest``` plugin as follows:
``` bash
vagrant plugin install vagrant-vbguest
```
