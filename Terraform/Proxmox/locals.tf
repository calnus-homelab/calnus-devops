
locals {
  proxmox_defaults = {
    proxmox_endpoint = "https://pve.lanfordlabs.com/"
    node_name        = "pve"
    storage_pool     = "Expel"
  }
  minio_defaults = {
    minio_endpoint = "https://s3.lanfordlabs.com"
  }

  node_defaults = {
    ssh_public_key = "id_rsa.pub"
    ami            = "ubuntu_24_04"
    instance_type  = "t3.large"
    gw_ip_address  = "192.168.1.1"
  }

  merged_images = {
    for name, cfg in local.images :
    name => merge(local.proxmox_defaults, cfg)
  }

  merged_nodes = {
    for name, cfg in local.nodes :
    name => merge(local.node_defaults, local.proxmox_defaults, local.minio_defaults, cfg)
  }
}
