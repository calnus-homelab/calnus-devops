variable node_name {
    description = "The pve node name"
    type = string
    default="pvekda"
}
variable storage_pool {
    description = "The pve node name"
    type = string
    default="local"
}
variable nvme_storage_pool {
    description = "The pve node name"
    type = string
    default="nvme"
}
variable promox_endpoint{
    description = "The pve node name"
    type = string
    default="https://192.168.68.103:8006/"
}
variable server_name{
    description = "The new server name"
    type = string
    default="ubuntu-k8s-node-1"
}
variable "ssh_public_key" {
  type        = string
  description = "SSH public key content (ssh-ed25519 ...)"
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAb9AnKMunSf/lpVMB0lJP9gFWkmnjE6ISe1s+ZvWo5x jose@MX-IT-JOSANTGAR"
}
variable cpu_type{
    description = "The new server type"
    type = string
    default="x86-64-v2-AES"
}
variable core_count{
    description = "The new server Core count"
    type = number
    default=4
}
variable memory{
    description = "The new server memory"
    type = number
    default=4096
}
variable "cloud_image" {
  description = "OS image"
  type =string
}
variable storage_size{
    description = "The new server Core count"
    type = number
    default=20
}
variable ip_address{
    description = "The new Ip address"
    type = string    
}
variable gw_ip_address{
    description = "The gw Ip address"
    type = string    
    default="192.168.68.1"
}
variable registry_cache{
    type=string
    default="http://192.168.68.9:5000"
}