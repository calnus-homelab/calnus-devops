
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
  create_duration = "5m"
}

resource "null_resource" "bootstrap" {
  depends_on = [time_sleep.wait_time]

  connection {
    type        = "ssh"
    host        = var.ip_address
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "2m"
  }

  # Subimos el script local->remoto
  provisioner "file" {
    source      = ("${path.module}/scripts/bootstrap.sh")
    destination = "/tmp/bootstrap.sh"
  }

  # Ejecutamos el script remotamente
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh"
    ]
  }

  triggers = {
    ip        = var.ip_address
    timestamp = timestamp()
  }
}


resource "null_resource" "fetch_remote_file" {
  depends_on = [null_resource.bootstrap]
  # Re-run when the instance id or its public_ip changes
  triggers = {
    instance_ip  = var.ip_address
    instance_key = proxmox_virtual_environment_vm.vm.id
    # if you later expose an id output from the module, replace/add:
    # instance_id = module.ubuntu_nodes[each.key].instance_id
  }

  # make sure instance is created first

  connection {
    type        = "ssh"
    host        = var.ip_address
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "2m"
  }

  # remote-exec: simple check so Terraform waits until SSH is ready
  provisioner "remote-exec" {
    inline = [
      "echo ssh-ready"
    ]
  }
  # local-exec: run on the machine executing terraform (this is the SCP)
  provisioner "local-exec" {
    command = <<EOT
    scp -o StrictHostKeyChecking=no -i ${var.private_key_path} ubuntu@${var.ip_address}:/tmp/bootstrap.log ${path.module}/logs/bootstrap_setup.log
EOT
    # optionally allow failure and continue:
    # on_failure = "continue"
  }
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

