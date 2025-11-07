locals {
  Name = var.server_name
  instance_type_map = {
    "t3.micro"   = { cores = 1, memory_mb = 1024, storage_gb = 10 }
    "t3.small"   = { cores = 2, memory_mb = 2048, storage_gb = 20 }
    "t3.medium"  = { cores = 2, memory_mb = 4096, storage_gb = 40 }
    "t3.large"   = { cores = 2, memory_mb = 8192, storage_gb = 60 }
    "m5.large"   = { cores = 2, memory_mb = 8192, storage_gb = 80 }
    "m5.xlarge"  = { cores = 4, memory_mb = 16384, storage_gb = 120 }
    "m5.2xlarge" = { cores = 8, memory_mb = 32768, storage_gb = 200 }
  }
  resolved_spec = lookup(
    local.instance_type_map,
    var.instance_type,
    local.instance_type_map["t3.small"]
  )
  password_hash = bcrypt(random_password.vm_password.result)

}