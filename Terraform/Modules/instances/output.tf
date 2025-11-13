output "ip_address" {
  value = var.ip_address
}

output "instance_type" {
  value = proxmox_virtual_environment_vm.vm.id  # or whatever resource you use
}

output "generated_password" {
  value     = random_password.vm_password.result
  sensitive = true
}
