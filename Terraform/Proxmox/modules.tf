module "iso_images" {
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

module "master_nodes" {
  depends_on = [module.iso_images]
  source   = "../Modules/instances"
  for_each = local.merged_master_nodes

  server_name        = each.key
  ip_address         = each.value.ip
  gw_ip_address      = each.value.gw_ip_address
  instance_type      = each.value.instance_type
  ssh_public_key     = each.value.ssh_public_key
  cloud_image        = module.iso_images[each.value.ami].id
  minio_access_key   = var.minio_access_key
  minio_secret_key   = var.minio_secret_key
  minio_endpoint     = each.value.minio_endpoint
  node_name          = each.value.node_name
  storage_pool       = each.value.storage_pool
  cni_manifest_url   = local.kubernetes_local.cni_manifest_url
  kubernetes_version = local.kubernetes_local.kubernetes_version
  time_zone          = local.kubernetes_local.time_zone
  master_count       = var.master_count
  worker_count       = var.worker_count
  network_cidr       = var.network_cidr
  start_ip_offset    = var.start_ip_offset
  providers = {
    proxmox = proxmox
  }
}

module "worker_nodes" {
  depends_on = [module.master_nodes]
  source     = "../Modules/instances"
  for_each   = local.merged_worker_nodes

  server_name        = each.key
  ip_address         = each.value.ip
  gw_ip_address      = each.value.gw_ip_address
  instance_type      = each.value.instance_type
  ssh_public_key     = each.value.ssh_public_key
  cloud_image        = module.iso_images[each.value.ami].id
  minio_access_key   = var.minio_access_key
  minio_secret_key   = var.minio_secret_key
  minio_endpoint     = each.value.minio_endpoint
  node_name          = each.value.node_name
  storage_pool       = each.value.storage_pool
  cni_manifest_url   = local.kubernetes_local.cni_manifest_url
  kubernetes_version = local.kubernetes_local.kubernetes_version
  time_zone          = local.kubernetes_local.time_zone
  master_count       = var.master_count
  worker_count       = var.worker_count
  network_cidr       = var.network_cidr
  start_ip_offset    = var.start_ip_offset

  providers = {
    proxmox = proxmox
  }
}
