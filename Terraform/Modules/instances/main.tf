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
      - ca-certificates
      - gnupg
      - lsb-release
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - mkdir -p /etc/apt/keyrings
      - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      - echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
      - apt-get update
      - apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
      - usermod -aG docker ubuntu
      - systemctl enable docker
      - systemctl start docker
      - echo "Docker and Docker Compose installed successfully" > /root/cloud-init.log
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
    user_account {      
      password = random_password.ubuntu_vm_password.result
      username = "ubuntu"
    }    
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id 
  }
  network_device {
    bridge = "vmbr0"
  }

}
resource "random_password" "ubuntu_vm_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}
output "ubuntu_vm_password" {
  value     = random_password.ubuntu_vm_password.result
  sensitive = true
}

