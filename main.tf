terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      version = ">= 0.6.2"
      source = "dmacvicar/libvirt"
    }
  }
}

locals {
  hosts = {
    "s0" = [ "default", "c0", "c2" ],
    "s1" = [ "default", "c1", "c3" ],
    "s2" = [ "default", "c0", "c3" ],
    "s3" = [ "default", "c1", "c2" ]
  }
}


resource "libvirt_network" "cable" {
  count = 4
  name = "c${count.index}"
  mode = "none"
  dns { local_only = true }
}

module "sonic" {
  source = "./modules/sonic"
  hosts = local.hosts
}
