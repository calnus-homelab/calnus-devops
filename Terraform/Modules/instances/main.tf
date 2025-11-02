locals {
 Name = var.server_name
}
resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = var.storage_pool
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/user-data-cloud-config.yaml", {
      Name           = local.Name
      ssh_public_key = trimspace(var.ssh_public_key)
      registry       = var.registry_cache
    })
    file_name = "user-data-cloud-config-${local.Name}.yaml"
  }
}



resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = local.Name
  node_name = var.node_name
  agent {
    enabled = true
  }
  cpu {
    cores = var.core_count
    type  = var.cpu_type
    units = 1024
  }
  memory {
    dedicated = var.memory
  }
  disk {
    datastore_id = var.nvme_storage_pool
    import_from  = var.cloud_image
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.storage_size
  }

  initialization {
    ip_config {
      ipv4 {
        #address = "dhcp"
        address = var.ip_address
        gateway = var.gw_ip_address
      }
    }   
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id 
  }
  network_device {
    bridge = "vmbr0"
  }

}

