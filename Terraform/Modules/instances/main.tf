locals {
  Name = var.server_name
  instance_type_map = {
    "t3.micro"   = { cores = 1, memory_mb = 1024, storage_gb = 10 }
    "t3.small"   = { cores = 2, memory_mb = 2048, storage_gb = 20 }
    "t3.medium"  = { cores = 2, memory_mb = 4096, storage_gb = 40 }
    "t3.large"   = { cores = 2, memory_mb = 8192, storage_gb = 60 }
    "m5.large"   = { cores = 2, memory_mb = 8192, storage_gb = 80 }
    "m5.xlarge"  = { cores = 4, memory_mb = 16384, storage_gb = 120 }
    "m5.2xlarge" = { cores = 8, memory_mb = 32768, storage_gb = 200 }
  }
  resolved_spec = lookup(
    local.instance_type_map,
    var.instance_type,
    local.instance_type_map["t3.small"]
  )


}
resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = var.storage_pool
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/user-data-cloud-config.yaml", {
      NAME               = local.Name
      SSH_PUBLIC_KEY     = trimspace(file(pathexpand("~/.ssh/${var.ssh_public_key}")))
      REGISTRY           = var.registry_cache
      KUBERNETES_VERSION = var.kuberentes_version
      TIME_ZONE          = var.time_zone
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
    cores = local.resolved_spec.cores
    type  = var.cpu_type
    units = 1024
  }
  memory {
    dedicated = local.resolved_spec.memory_mb
  }
  disk {
    datastore_id = var.nvme_storage_pool
    import_from  = var.cloud_image
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = local.resolved_spec.storage_gb
  }

  initialization {
    ip_config {
      ipv4 {
        #address = "dhcp"
        address = "${var.ip_address}/24"
        gateway = var.gw_ip_address
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }
  network_device {
    bridge = "vmbr0"
  }

}

