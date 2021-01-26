terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      version = ">= 0.6.2"
      source = "dmacvicar/libvirt"
    }
  }
}

variable "hostname" { default = "sonic" }
variable "memory" { default = "2048" }
variable "cpu" { default = 1 }
variable "eth0" { default = "default" }
variable "Ethernet0" { default = "default" }
variable "Ethernet4" { default = "default" }

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "os-image" {
  name = "${var.hostname}-disk.qcow2"
  source = "${path.module}/sonic-vs.img"
  format = "qcow2"
}

resource "libvirt_domain" "domain-sonic" {
  name = var.hostname
  memory = var.memory
  vcpu = var.cpu

  disk { volume_id = libvirt_volume.os-image.id }

  network_interface {
    network_name = var.eth0
  }
  network_interface {
    network_name = var.Ethernet0
  }
  network_interface {
    network_name = var.Ethernet4
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
