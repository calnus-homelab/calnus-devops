terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}

provider "proxmox" {
  endpoint = "https://pve-local.lanfordlabs.com/"
  insecure = true
  ssh {
    agent = true
  }
}