terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      version = ">= 0.6.2"
      source = "dmacvicar/libvirt"
    }
  }
}

variable "memory" { default = "2048" }
variable "cpu" { default = 1 }
variable "hosts" { type = map(list(string)) }

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "os-image" {
  for_each = var.hosts
  name = "${each.key}-disk.qcow2"
  source = "${path.module}/debian10-gns3.qcow2"
  format = "qcow2"
}

resource "libvirt_domain" "domain-debian" {
  for_each = var.hosts
  name = each.key
  memory = var.memory
  vcpu = var.cpu

  disk { volume_id = libvirt_volume.os-image[each.key].id }

  dynamic network_interface {
    for_each = each.value
    content {
      network_name = network_interface.value
      mac = format("52:54:00:11:%02X:%02X",
                   index(keys(var.hosts), each.key),
                   index(values(network_interface), network_interface.value))
    }
  }

  console {
    type = "pty"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = "true"
  }
}