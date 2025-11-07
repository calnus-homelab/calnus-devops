
locals {
  nodes = {
    "Master" = {
      ip  = "192.168.68.28"
      ami = "ubuntu_24_04"

    }
    "Worker-2" = {
      ip  = "192.168.68.29"
      ami = "ubuntu_24_04"

    }
  }
}
