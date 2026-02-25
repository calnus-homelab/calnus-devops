
module "K3s_instances" {
  source            = "../Modules/instances"
  for_each          = local.cluster_nodes
  node_name         = local.proxmox_defaults.node_name
  server_name       = each.key
  ip_address        = each.value.ip
  ssh_public_key    = lookup(each.value, "ssh_public_key", local.ssh_public_key)
  nvme_storage_pool = lookup(each.value, "nvme_storage_pool", local.nvme_storage_pool)
  cloud_image       = lookup(each.value, "cloud_image", local.cloud_image)
  instance_type     = lookup(each.value, "instance_type", local.instance_type)
  storage_size      = lookup(each.value, "storage_size", local.storage_size)
  hostpci_id        = lookup(each.value, "hostpci_id", local.hostpci_id)
}
