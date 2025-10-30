locals {
 Name = var.server_name
}
resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = var.storage_pool
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${local.Name}
    timezone: America/Mexico_City
    users:
      - default
      - name: ubuntu
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(var.ssh_public_key)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
      - net-tools
      - curl
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF
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
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }
  network_device {
    bridge = "vmbr0"
  }

}
