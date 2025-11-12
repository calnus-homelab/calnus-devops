
locals {
  defaults = {
    ssh_public_key   = "id_rsa.pub"
    ami              = "ubuntu_24_04"
    instance_type    = "t3.medium"
    ssh_public_key   = "id_ed25519.pub"
    node_name        = "pve"
    storage_pool     = "Expel"
    minio_endpoint   = "https://s3.lanfordlabs.com"
    proxmox_endpoint = "https://pve.lanfordlabs.com/"
    terraform_state_key = "pve/terraform.tfstate"   
  }


  merged_nodes = {
    for name, cfg in local.nodes :
    name => merge(local.defaults, cfg)
  }
}
