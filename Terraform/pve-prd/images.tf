
locals {
  images = {
    ubuntu_24_04 = {
      storage_pool = "local"
      remote_url   = "https://seafile.lanfordlabs.com/ubuntu/noble-server-cloudimg-amd64.img"
      image_name   = "ubuntu_24_04.qcow2"
    }
    ubuntu_20_04 = {
      storage_pool = "local"
      remote_url   = "https://seafile.lanfordlabs.com/ubuntu/jammy-server-cloudimg-amd64.img"
      image_name   = "ubuntu_22_04.qcow2"
    }
  }
  merged_images = {
    for name, cfg in local.images :
    name => merge(local.proxmox_defaults, cfg)
  }
}

module "images" {
  source       = "../Modules/images"
  for_each     = local.merged_images
  remote_url   = each.value.remote_url
  image_name   = each.value.image_name
  node_name    = each.value.node_name
  storage_pool = each.value.storage_pool
  providers = {
    proxmox = proxmox
  }
}
