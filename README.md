# terraform-provider-libvirt SONiC example

Abstract
--------

- Four SONiC VMs are deployed with Terraform.
- VMs are connected via virtual network.


Topology
--------

```
     (default)                        (default)
     eth0|                                |eth0
      ---+---Ethernet4        Ethernet4---+---
      | s0  |------------.           .-| s1  |
      ---+---            |           | ---+---
Ethernet0|               c2          |    |Ethernet0
         |               |           |    |
        c0    .-----c3---------------'    c1
         |    |          |                |
Ethernet0|    |          |                |Ethernet0
      ---+--- |          `-----------. ---+---
      | s2  |-'Ethernet4    Ethernet4`-| s3  |
      ---+---                          ---+---
     eth0|                                |eth0
     (default)                        (default)
```

Requirement
-----------

- libvirt
- qemu-kvm
- Terraform
- [terraform-provider-libvirt](https://github.com/dmacvicar/terraform-provider-libvirt)

Installation instruction example in Ubuntu 20.04LTS are below.

```
echo 'deb http://download.opensuse.org/repositories/systemsmanagement:/terraform/Ubuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/systemsmanagement:terraform.list
curl -fsSL https://download.opensuse.org/repositories/systemsmanagement:terraform/Ubuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/systemsmanagement_terraform.gpg > /dev/null
sudo apt update
sudo apt install -y terraform-provider-libvirt
sudo apt install -y libvirt-bin qemu-kvm terraform
mkdir -p ~/.local/share/terraform/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.2/linux_amd64
cp -p /usr/bin/terraform-provider-libvirt ~/.local/share/terraform/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.2/linux_amd64
```

Prepare
-------

Put `sonic-vs.img` into `modules/sonic/`.
`sonic-vs.img` is available at [last successful build of buildimage-vs-image](https://sonic-jenkins.westus2.cloudapp.azure.com/job/vs/job/buildimage-vs-image/lastSuccessfulBuild/artifact/target/).
Or use your own built image.

Usage
-----

1. Run Terraform.

```
cd terraform-libvirt-sonic-example
terraform init
terraform apply
```

2. `sudo rm /etc/sonic/config_db.json; sudo config-setup factory` for each VM.

3. Reboot all VMs.
