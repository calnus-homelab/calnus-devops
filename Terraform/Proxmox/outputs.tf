output "master_node_ips" {
  description = "IP addresses of all master nodes"
  value = {
    for name, mod in module.master_nodes :
    name => mod.ip_address
  }
}


output "worker_node_ips" {
  description = "IP addresses of all worker nodes"
  value = {
    for name, mod in module.worker_nodes :
    name => mod.ip_address
  }
}

output "master_node_passwords" {
  description = "dinamic generatos pssword"
  value = {
    for name, mod in module.master_nodes :
    name => mod.generated_password
  }
  sensitive = true
}
output "worker_node_passwords" {
  description = "dinamic generatos pssword"
  value = {
    for name, mod in module.worker_nodes :
    name => mod.generated_password
  }
  sensitive = true
}