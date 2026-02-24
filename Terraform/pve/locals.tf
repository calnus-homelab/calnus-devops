locals {
  proxmox_defaults = {
    proxmox_endpoint  = "https://192.168.1.10:8006/"
    node_name         = "ms-01"
    storage_pool      = "local"
    nvme_storage_pool = "local-lvm"
  }
  minio_defaults = {
    minio_endpoint = "https://s3.lanfordlabs.com"
  }
}
