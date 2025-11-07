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
variable "remote_url" {
  type        = string
  description = "Remote URL"
}
variable "image_name" {
  type        = string
  description = "local Image Name"
}
variable "upload_timeout" {
  description = "upload time out"
  type        = number
  default     = 1200
}
