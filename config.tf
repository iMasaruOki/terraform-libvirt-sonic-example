#
# sonic_hosts = {
#   "VMname1" = {
#     "cpu" = 1,
#     "mem" = 2048,
#     "nic" = [ "eth0-network", "Ethernet0-network", ... ]
#   },
#   "VMname2" = {
#     ...
#   }
#

locals {
  private_network = [ "l2sw0", "c0", "c1", "c2", "c3" ]
  debian_hosts = {
    "d0" = { "nic" = [ "hostnet", "l2sw0" ] }
  }
  sonic_hosts = {
    "s0" = { "nic" = [ "hostnet", "c0", "c2", "l2sw0" ] },
    "s1" = { "nic" = [ "hostnet", "c1", "c3", "l2sw0" ] },
    "s2" = { "nic" = [ "hostnet", "c0", "c3" ] },
    "s3" = { "nic" = [ "hostnet", "c1", "c2" ] }
  }
}
