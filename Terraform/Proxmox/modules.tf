module "ubuntu_images" {
  source     = "../Modules/images"
  for_each   = local.images
  remote_url = each.value.remote_url
  image_name = each.value.image_name

  providers = {
    proxmox = proxmox
  }
}

module "ubuntu_nodes" {
  source   = "../Modules/instances"
  for_each = local.merged_nodes

  server_name      = each.key
  ip_address       = each.value.ip
  instance_type    = each.value.instance_type
  ssh_public_key   = each.value.ssh_public_key
  cloud_image      = module.ubuntu_images[each.value.ami].id
  minio_access_key = var.minio_access_key
  minio_secret_key = var.minio_secret_key
  providers = {
    proxmox = proxmox
  }
}
