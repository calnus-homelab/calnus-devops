
locals {
  nodes = {
    "Master" = {
      ip             = "192.168.68.28"
      ami            = "ubuntu_24_04"
      instance_type  = "t3.large"
      ssh_public_key = "id_ed25519.pub"
    }
    "Worker-2" = {
      ip             = "192.168.68.29"
      ami            = "ubuntu_24_04"
      instance_type  = "t3.large"
      ssh_public_key = "id_ed25519.pub"
    }
  }
}
