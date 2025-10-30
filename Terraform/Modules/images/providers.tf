terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}

provider "proxmox" {
  endpoint = "https://192.168.68.103:8006/"
  insecure = true
  ssh {
    agent = true
  }
}