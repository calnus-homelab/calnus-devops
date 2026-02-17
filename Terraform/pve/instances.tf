locals {
  nodes = {
    master-01 = {
      ip            = "192.168.1.60"
      instance_type = "t3.medium"
    }
    worker-01 = {
      ip            = "192.168.1.61"
      instance_type = "m5.large"
    }
    worker-02 = {
      ip            = "192.168.1.62"
      instance_type = "m5.large"
    }
    worker-03 = {
      ip            = "192.168.1.63"
      instance_type = "m5.large"
    }
  }
}
module "k3s_workers" {
  for_each          = local.nodes
  source            = "../Modules/instances"
  node_name         = "pve-ms1"
  server_name       = each.key
  cloud_image       = module.images.ubuntu_24_04.id
  instance_type     = each.value.instance_type
  storage_size      = 40
  minio_endpoint    = ""
  ip_address        = each.value.ip
  minio_secret_key  = ""
  minio_access_key  = ""
  ssh_public_key    = "id_rsa.pub"
  nvme_storage_pool = "local-lvm"

  depends_on = [module.images]
}
