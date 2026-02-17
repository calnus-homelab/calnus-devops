
resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = var.storage_pool
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/scripts/user-data-cloud-config.yaml", {
      NAME               = local.Name
      SSH_PUBLIC_KEY     = trimspace(file(pathexpand("~/.ssh/${var.ssh_public_key}")))
      REGISTRY           = var.registry_cache
      KUBERNETES_VERSION = var.kubernetes_version
      TIME_ZONE          = var.time_zone
      NEW_PASSWORD       = local.password_hash
      MINIO_ACCESS_KEY   = var.minio_access_key
      MINIO_SECRET_KEY   = var.minio_secret_key
      MINIO_ENDPOINT     = var.minio_endpoint
      POD_NETWORK_CIDR   = "10.244.0.0/16"
      CNI_MANIFEST_URL   = var.cni_manifest_url

    })
    file_name = "user-data-cloud-config-${local.Name}.yaml"
  }
  lifecycle {
    ignore_changes = [
      source_raw
    ]
  }
}



resource "proxmox_virtual_environment_vm" "vm" {
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
    size         = var.storage_size
  }
  lifecycle {
    ignore_changes = [ ]
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
    bridge       = "vmbr0"
    disconnected = false
  }
}

resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "!@#%^&*()-_=+[]{}<>:?" # optional, controls which special chars are allowed
}

resource "time_sleep" "wait_time" {
  depends_on      = [proxmox_virtual_environment_vm.vm]
  create_duration = "3s"
}


resource "null_resource" "cleanup_ssh" {
  # capture IP in triggers so this null_resource depends on the VM
  triggers = {
    vm_ip = var.ip_address
    # add other stable triggers if needed, e.g. instance id
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
ssh-keygen -R "${self.triggers["vm_ip"]}" 2>/dev/null || true
echo "Cleaned known_hosts entry for ${self.triggers["vm_ip"]}"
EOT
  }
}

