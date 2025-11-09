

locals {
  nodes = {
    "Master" = {
      ip             = "192.168.68.28"
      ami            = "ubuntu_24_04"
      instance_type  = "t3.large"
      ssh_public_key = "id_ed25519.pub"
    }
    #"Worker-2" = {
    #  ip             = "192.168.68.29"
    #  ami            = "ubuntu_24_04"
    #  instance_type  = "t3.large"
    #  ssh_public_key = "id_ed25519.pub"
    #}
  }
}
variable "private_key_path" {
  type    = string
  default = "/home/jose/.ssh/id_ed25519" # ruta a la clave privada usada para SSH
}
resource "time_sleep" "wait_time" {
  depends_on     = [module.ubuntu_nodes]
  create_duration = "4m"
}


resource "null_resource" "bootstrap" {
  for_each = local.merged_nodes
  depends_on = [time_sleep.wait_time]

  connection {
    type        = "ssh"
    host        = each.value.ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "2m"
  }

  # Subimos el script local->remoto
  provisioner "file" {
    source      = "scripts/bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  # Ejecutamos el script remotamente
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo /tmp/bootstrap.sh"
    ]
  }

  triggers = {
    ip        = each.value.ip
    timestamp = timestamp()
  }
}
