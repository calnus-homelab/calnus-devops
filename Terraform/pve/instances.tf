locals {
  default_worker_instance_type = "m5.2large"
  cloud_image                  = module.images.ubuntu_24_04.id
  hostpci_id                   = null
  storage_size                 = 40
  nodes = {
    master-01 = {
      ip            = "192.168.1.60"
      instance_type = "t3.medium"
      storage_size  = 50
    }
    worker-01 = {
      ip         = "192.168.1.61"
      hostpci_id = "0000:01:00"
    }
    worker-02 = {
      ip         = "192.168.1.62"
      hostpci_id = "0000:02:00"
    }
    worker-03 = {
      ip         = "192.168.1.63"
      hostpci_id = "0000:59:00"
    }
  }
}
module "K3s_instances" {
  source            = "../Modules/instances"
  for_each          = local.nodes
  node_name         = var.node_name
  server_name       = each.key
  ip_address        = each.value.ip
  ssh_public_key    = var.ssh_public_key
  nvme_storage_pool = var.storage_pool
  cloud_image       = lookup(each.value, "cloud_image", local.cloud_image)
  instance_type     = lookup(each.value, "instance_type", local.default_worker_instance_type)
  storage_size      = lookup(each.value, "storage_size", var.storage_size)
  hostpci_id        = lookup(each.value, "hostpci_id", local.hostpci_id)
}
