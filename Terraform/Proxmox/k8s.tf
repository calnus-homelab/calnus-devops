
locals {
  nodes = {
    "Master"   = "192.168.68.28"
    "Worker-2" = "192.168.68.29"
  }
}


module "ubuntu_nodes" {
  source         = "../Modules/instances"
  instance_type  = "m5.large"
  ssh_public_key = "id_ed25519.pub"
  for_each       = local.nodes
  server_name    = each.key
  ip_address     = each.value
  cloud_image    = module.ubuntu_cloudimg_24_04.id
  providers = {
    proxmox = proxmox
  }
}
