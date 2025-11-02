module "ubuntu_cloudimg_22_04" {
  source     = "../Modules/images"
  remote_url = "https://isos.lanfordlabs.com/jammy-server-cloudimg-amd64.img"
  image_name = "jammy-server-cloudimg-amd64-22.04.qcow2"
}
module "ubuntu_cloudimg_24_04" {
  source     = "../Modules/images"
  remote_url = "https://isos.lanfordlabs.com/noble-server-cloudimg-amd64.img"
  image_name = "noble-server-cloudimg-amd64-24.04.qcow2"
}