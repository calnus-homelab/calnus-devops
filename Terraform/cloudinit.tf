variable "ubuntu_password" {
  description = "Password for Ubuntu user"
  type        = string
  sensitive   = true
}

resource "harvester_cloudinit_secret" "cloud-config-ubuntu20" {
  name      = "cloud-config-ubuntu20"
  namespace = "default"

  user_data    = <<-EOF
    #cloud-config
    password: ${var.ubuntu_password}
    chpasswd:
      expire: false
    ssh_pwauth: true
    package_update: true
    packages:
      - qemu-guest-agent
    runcmd:
      - - systemctl
        - enable
        - '--now'
        - qemu-guest-agent
    EOF
  network_data = ""
}
