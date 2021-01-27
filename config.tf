locals {
  cables = [ "c0", "c1", "c2", "c3" ]
  debian_hosts = {
  // VMname     eth0       eth1       eth2  ...
  }
  sonic_hosts = {
  // VMname     eth0       Ethernet0  Ethernet4  ...
    "s0"    = [ "default", "c0",      "c2" ],
    "s1"    = [ "default", "c1",      "c3" ],
    "s2"    = [ "default", "c0",      "c3" ],
    "s3"    = [ "default", "c1",      "c2" ]
  }
}
