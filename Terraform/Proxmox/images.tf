
locals {
  images = {
    ubuntu_24_04 = {
      remote_url   = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
      image_name   = "ubuntu_24_04.qcow2"
      node_name    = local.defaults.node_name
      storage_pool = local.defaults.storage_pool
    }
  }
}
