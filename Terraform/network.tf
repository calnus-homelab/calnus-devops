resource "harvester_network" "local-vlan" {
  name                 = "local-vlan"
  namespace            = "harvester-public"
  vlan_id              = 0    
  cluster_network_name = "mgmt"  
}

resource "harvester_loadbalancer" "service_loadbalancer" {
  name = "service-loadbalancer"

  #depends_on = [
  #  harvester_virtualmachine.name
  #]

  listener {
    # Each listener must have a unique name
    name         = "https"
    port         = 443
    protocol     = "tcp"
    backend_port = 443
  }

  listener {
    name         = "http"
    port         = 80
    protocol     = "tcp"
    backend_port = 80
  }

  # Can be "pool" or "dhcp"
  ipam = "dhcp"

  # Only applicable if ipam="pool"
  #ippool = "service-ips"

  # Can be "vm" or "cluster"
  workload_type = "vm"

  # This must be a label on the VirtualMachineInstance
  backend_selector {
    key    = "harvesterhci.io/vmName"
    values = ["truenas"]
  }

  healthcheck {
    # Must be the same as one of the listener backend ports
    port = 80

    success_threshold = 1
    failure_threshold = 3
    period_seconds    = 10
    timeout_seconds   = 5
  }
}