terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}

provider "proxmox" {
  endpoint = local.defaults.proxmox_endpoint
  insecure = true
  ssh {
    agent = true
  }
}