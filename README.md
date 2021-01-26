# terraform-provider-libvirt SONiC example

Abstract
--------

- Two SONiC VMs are deployed with Terraform.
- VMs are connected via virtual network.


Topology
--------

```
(default)                      (default)
eth0|                              |eth0
 ---+---                        ---+---
 | s1  |                        | s2  |
 ---+---                        ---+---
    |Ethernet0            Ethernet0|
    ---------------c1---------------
```

Requirement
-----------

- libvirt
- qemu-kvm
- Terraform
- terraform-provider-libvirt


Prepare
-------

Put `sonic-vs.img` into modules/sonic/.

Usage
-----

1. Run Terraform.

```
cd terraform-libvirt-sonic-example
terraform init
terraform apply
```

2. Edit `"mac"` in `/etc/sonic/config_db.json` and reboot Vm.
