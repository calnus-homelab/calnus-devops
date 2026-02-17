locals {
  proxmox_defaults = {
    proxmox_endpoint  = "https://192.168.1.30:8006/"
    node_name         = "pve-ms1"
    storage_pool      = "local"
    nvme_storage_pool = "nvme"
  }
  minio_defaults = {
    minio_endpoint = "https://s3.lanfordlabs.com"
  }
}
