
locals {
  images = {
    ubuntu_22_04 = {
      remote_url = "https://isos.lanfordlabs.com/jammy-server-cloudimg-amd64.img"
      image_name = "ubuntu_22_04.qcow2"
    }
    ubuntu_24_04 = {
      remote_url = "https://isos.lanfordlabs.com/noble-server-cloudimg-amd64.img"
      image_name = "ubuntu_24_04.qcow2"
    }
  }
}