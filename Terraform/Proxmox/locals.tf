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
    instance_type  = "t3.medium"
    gw_ip_address  = "192.168.1.1"
  }

  kubernetes_local = {
    kubernetes_version = "v1.34"
    time_zone          = "America/Mexico_City"
    cni_manifest_url    = "https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
  }

  merged_images = {
    for name, cfg in local.images :
    name => merge(local.proxmox_defaults, cfg)
  }

  merged_master_nodes= {
    for name, cfg in local.masters :
    name => merge(local.node_defaults, local.proxmox_defaults, local.minio_defaults, cfg)
  }
  merged_worker_nodes = {
    for name, cfg in local.workers :
    name => merge(local.node_defaults, local.proxmox_defaults, local.minio_defaults, cfg)
  }
  
  masters = {
    for i in range(var.master_count) :
    format("Master-%02d", i + 1) => {
      role = "master"
      ip   = cidrhost(var.network_cidr, var.start_ip_offset + i)
      index = i
    }
  }
  
  workers = {
    for i in range(var.worker_count) :
    format("worker-%02d", i + 1) => {
      role = "worker"
      ip   = cidrhost(var.network_cidr, var.start_ip_offset + var.master_count + i)
      index = i
    }
  }
}
