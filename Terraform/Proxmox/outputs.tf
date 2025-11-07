output "node_ips" {
  description = "IP addresses of all Ubuntu nodes"
  value = {
    for name, mod in module.ubuntu_nodes :
    name => mod.ip_address
  }
}


output "node_instances" {
  description = "Instance identifiers of all Ubuntu nodes"
  value = {
    for name, mod in module.ubuntu_nodes :
    name => mod.instance_type
  }
}

output "node_passwords" {
  description = "dinamic generatos pssword"
  value = {
    for name, mod in module.ubuntu_nodes :
    name => mod.generated_password
  }
  sensitive = true
}
