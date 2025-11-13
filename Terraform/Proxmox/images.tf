
locals {
  images = {
    ubuntu_24_04 = {
      remote_url   = "http://seafile.lanfordlabs.com/f/38e6ba3a19054760ae76/?dl=1"
      image_name   = "ubuntu_24_04.qcow2"
      node_name    = local.defaults.node_name
      storage_pool = local.defaults.storage_pool
    }
  }
}
