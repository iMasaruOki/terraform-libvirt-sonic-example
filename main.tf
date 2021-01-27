terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      version = ">= 0.6.2"
      source = "dmacvicar/libvirt"
    }
  }
}

resource "libvirt_network" "cable" {
  for_each = toset(local.cables)
  name = each.key
  mode = "none"
  dns { local_only = true }
}

module "debian" {
  source = "./modules/debian"
  hosts = local.debian_hosts
}

module "sonic" {
  source = "./modules/sonic"
  hosts = local.sonic_hosts
}
