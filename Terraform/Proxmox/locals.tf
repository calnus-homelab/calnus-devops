
locals {
  defaults = {
    ssh_public_key      = "id_rsa.pub"
    ami                 = "ubuntu_24_04"
    instance_type       = "t3.large"
    node_name           = "pve"
    storage_pool        = "Expel"
    minio_endpoint      = "https://s3.lanfordlabs.com"
    proxmox_endpoint    = "https://pve.lanfordlabs.com/"
    gw_ip_address       = "192.168.1.1"
  }


  merged_nodes = {
    for name, cfg in local.nodes :
    name => merge(local.defaults, cfg)
  }
}
