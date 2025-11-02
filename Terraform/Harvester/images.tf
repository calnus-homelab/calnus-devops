resource "harvester_image" "k3os" {
  name               = "k3os"
  namespace          = "harvester-public"
  storage_class_name = "harvester-longhorn"
  display_name       = "k3os"
  source_type        = "download"
  url                = "https://github.com/rancher/k3os/releases/download/v0.20.6-k3s1r0/k3os-amd64.iso"
}

resource "harvester_image" "ubuntu20" {
  name               = "ubuntu20"
  namespace          = "harvester-public"
  storage_class_name = "harvester-longhorn"
  display_name       = "ubuntu-20.04-server-cloudimg-amd64.img"
  source_type        = "download"
  url                = "http://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
}


resource "harvester_image" "truenas-scale" {
  name               = "truenas-scale"
  namespace          = "harvester-public"
  storage_class_name = "harvester-longhorn"
  display_name       = "TrueNAS-SCALE-25.04.2.1.iso"
  source_type        = "download"
  url                = "https://download.sys.truenas.net/TrueNAS-SCALE-Fangtooth/25.04.2.1/TrueNAS-SCALE-25.04.2.1.iso"
}