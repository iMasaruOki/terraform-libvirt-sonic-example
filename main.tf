terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      version = ">= 0.6.2"
      source = "dmacvicar/libvirt"
    }
  }
}

resource "libvirt_network" "s1-s2" {
  name = "c1"
  mode = "none"
  dns { local_only = true }
}

module "sonic-1" {
  source = "./modules/sonic"
  hostname = "s1"
  Ethernet0 = "c1"
}

module "sonic-2" {
  source = "./modules/sonic"
  hostname = "s2"
  Ethernet0 = "c1"
}
