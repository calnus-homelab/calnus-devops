
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

}
