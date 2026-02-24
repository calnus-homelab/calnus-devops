locals {
  proxmox_defaults = {
    proxmox_endpoint = "https://192.168.1.10:8006/"
    node_name        = "ms-01"
  }
  instance_type = "m5.2large"
  cloud_image                  = module.images.ubuntu_24_04.id
  hostpci_id                   = null
  storage_size                 = 40
  ssh_public_key               = var.ssh_public_key
  nvme_storage_pool            = var.storage_pool

  cluster_nodes = {
    master-01 = {
      ip            = "192.168.1.60"
      instance_type = "t3.medium"
    }
    worker-01 = {
      ip         = "192.168.1.61"
      hostpci_id = "0000:02:00"
    }
    worker-02 = {
      ip         = "192.168.1.62"
      hostpci_id = "0000:59:00"
    }
    worker-03 = {
      ip         = "192.168.1.63"
      hostpci_id = "0000:01:00"
    }
  }
}
