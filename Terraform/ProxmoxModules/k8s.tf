

module "ubuntu-node-1" {
  source = "../Modules/instances"
  storage_pool = "local"
  nvme_storage_pool = "nvme"
  server_name = "ubuntu-k8s-node-1"
  core_count = 4
  memory = 8192
  cloud_image = module.ubuntu_loudimg_24_04.id
 }

module "ubuntu-node-2" {
  source = "../Modules/instances"
  storage_pool = "local"
  nvme_storage_pool = "nvme"
  server_name = "ubuntu-k8s-node-2"
  core_count = 4
  memory = 8192
  cloud_image = module.ubuntu_loudimg_24_04.id
 }