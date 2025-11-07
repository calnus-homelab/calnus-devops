
locals {
  nodes = {
    "master" = "192.168.68.28/24"
    "node-2" = "192.168.68.29/24"
    "node-3" = "192.168.68.30/24"
  }
}

module "ubuntu_nodes" {
  source            = "../Modules/instances"
  for_each          = local.nodes
  storage_pool      = "local"
  nvme_storage_pool = "nvme"
  server_name       = "k8s-${each.key}"
  ip_address        = each.value
  core_count        = 4
  memory            = 7168
  storage_size      = 64
  cloud_image       = module.ubuntu_cloudimg_24_04.id
  providers = {
    proxmox = proxmox
  }
}
