resource "proxmox_virtual_environment_download_file" "cloud_image" {
  content_type   = "import"
  datastore_id   = var.storage_pool
  node_name      = var.node_name
  url            = var.remote_url
  file_name      = var.image_name
  upload_timeout = var.upload_timeout
}
output "id" {
  value = proxmox_virtual_environment_download_file.cloud_image.id
}
