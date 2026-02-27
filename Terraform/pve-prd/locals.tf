locals {
  proxmox_defaults = {
    proxmox_endpoint = "https://192.168.1.2:8006/"
    node_name        = "pve"
  }
  instance_type     = "m5.large"
  cloud_image       = module.images.ubuntu_24_04.id
  hostpci_id        = null
  storage_size      = 40
  ssh_public_key    = var.ssh_public_key
  nvme_storage_pool = var.storage_pool

  cluster_nodes = {
    master-01 = {
      ip            = "192.168.1.20"
      instance_type = "t3.medium"
    }
    worker-01 = {
      ip = "192.168.1.21"
    }
    worker-02 = {
      ip = "192.168.1.22"
    }
    worker-03 = {
      ip = "192.168.1.23"
    }
  }
}
