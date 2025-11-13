

locals {

  nodes = {
    "Master" = {
      ip = "192.168.1.50"
    }
  }
}




variable "private_key_path" {
  type    = string
  default = "/home/jose/.ssh/id_rsa" # ruta a la clave privada usada para SSH
}

