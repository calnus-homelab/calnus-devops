
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
      NEW_PASSWORD       = local.password_hash
      MINIO_ACCESS_KEY   = var.minio_access_key
      MINIO_SECRET_KEY   = var.minio_secret_key
      MINIO_ENDPOINT     = var.minio_endpoint
      POD_NETWORK_CIDR   = "172.16.0.0/16"
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
    datastore_id = var.storage_pool
    import_from  = var.cloud_image
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = local.resolved_spec.storage_gb
  }
  lifecycle {
    ignore_changes = [
      network_device,
      vga
    ]
  }
  initialization {
    datastore_id = var.storage_pool
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
    disconnected = false
    }
}

resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "!@#%^&*()-_=+[]{}<>:?" # optional, controls which special chars are allowed
}
