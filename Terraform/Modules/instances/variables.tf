variable "node_name" {
  description = "The pve node name"
  type        = string
  default     = "pvekda"
}
variable "storage_pool" {
  description = "The pve node name"
  type        = string
  default     = "local"
}
variable "nvme_storage_pool" {
  description = "The pve node name"
  type        = string
  default     = "nvme"
}
variable "promox_endpoint" {
  description = "The pve node name"
  type        = string
  default     = "https://192.168.68.103:8006/"
}
variable "server_name" {
  description = "The new server name"
  type        = string
  default     = "ubuntu-k8s-node-1"
}
variable "ssh_public_key" {
  type        = string
  description = "SSH public key path (~/.ssh/id_rsa.pub)"
}
variable "cpu_type" {
  description = "The new server type"
  type        = string
  default     = "x86-64-v2-AES"
}
variable "cloud_image" {
  description = "OS image"
  type        = string
}
variable "storage_size" {
  description = "The new server Core count"
  type        = number
  default     = 2
}
variable "ip_address" {
  description = "The new Ip address"
  type        = string
}
variable "gw_ip_address" {
  description = "The gw Ip address"
  type        = string
  default     = "192.168.1.1"
}
variable "registry_cache" {
  type    = string
  default = "192.168.68.9:5000"
}
variable "kuberentes_version" {
  type    = string
  default = "v1.34"
}
variable "time_zone" {
  type    = string
  default = "America/Mexico_City"
}
variable "instance_type" {
  type        = string
  description = "EC2-style instance type name (e.g. t3.small, m5.large)."
}

variable "minio_access_key" {
  type        = string
  description = "MinIO access key"
  sensitive   = true
}

variable "minio_secret_key" {
  type        = string
  description = "MinIO secret key"
  sensitive   = true
}

variable "minio_endpoint" {
  type        = string
  description = "MinIO endpoint URL"
}