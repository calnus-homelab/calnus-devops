

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
  create_duration = "3m"
}


resource "null_resource" "fetch_uuid" {
  for_each = local.merged_nodes 
  depends_on = [time_sleep.wait_time]  
  triggers = {
    ip        = each.value.ip
    timestamp = timestamp()
  }
  connection {
    type        = "ssh"
    host        = each.value.ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "2m"           
  }
  provisioner "remote-exec" {    
    inline = [
      "set -e",
      "cat /etc/machine-id > /tmp/result_uuid.txt || echo 'no-machine-id' > /tmp/result_uuid.txt",
      "sudo kubeadm init --pod-network-cidr=10.168.0.0/16 > kubeadm-init.log 2>&1",
      "mkdir -p $HOME/.kube",
      "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config",
      "sudo chown $(id -u):$(id -g) $HOME/.kube/config",
      "kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml"   
      ]
  }
}

