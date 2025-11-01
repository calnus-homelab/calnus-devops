module "ubuntu-node-1" {
  source            = "../Modules/instances"
  storage_pool      = "local"
  nvme_storage_pool = "nvme"
  server_name       = "ubuntu-k8s-node-1"
  ip_address        ="192.168.68.25/24"
  core_count        = 4
  memory            = 7168
  storage_size      = 64
  cloud_image       = module.ubuntu_loudimg_24_04.id
}

module "ubuntu-node-2" {
  source            = "../Modules/instances"
  storage_pool      = "local"
  nvme_storage_pool = "nvme"
  server_name       = "ubuntu-k8s-node-2"
  ip_address        = "192.168.68.26/24"
  core_count        = 4
  memory            = 7168
  storage_size      = 64
  cloud_image       = module.ubuntu_loudimg_24_04.id
}
module "ubuntu-node-3" {
  source            = "../Modules/instances"
  storage_pool      = "local"
  nvme_storage_pool = "nvme"
  server_name       = "ubuntu-k8s-node-3"
  ip_address        ="192.168.68.27/24"
  core_count        = 4
  memory            = 7168
  storage_size      = 64
  cloud_image       = module.ubuntu_loudimg_24_04.id
}
