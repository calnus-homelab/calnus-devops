resource "harvester_virtualmachine" "truenas" {
  name                 = "truenas"
  namespace            = "default"
  restart_after_update = true

  description = "truenas Server"

  cpu    = 4
  memory = "4Gi"

  efi         = true
  secure_boot = false

  run_strategy    = "RerunOnFailure"
  hostname        = "truenas"
  reserved_memory = "100Mi"
  machine_type    = "q35"

  network_interface {
    name           = "nic-1"
    wait_for_lease = true
  }
  #this is the disk for the truenas scale iso, it will not boot, but it will allow you to install truenas scale on the empty disk
  #disk {
  #  name       = "truenas-iso"
  #  type       = "disk"    
  #  bus        = "virtio"
  #  boot_order = 1
  #  image       = harvester_image.truenas-scale.id
  #  auto_delete = true
  #}

  disk {
    name        = "rootdisk"
    type        = "disk"
    size        = "32Gi"
    bus         = "virtio"
    auto_delete = true
  }  
}

