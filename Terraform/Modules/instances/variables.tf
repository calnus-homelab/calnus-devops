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
  default     = "https://192.168.1.30:8006/"
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
  default     = "host"
}
variable "cloud_image" {
  description = "OS image"
  type        = string
}
variable "storage_size" {
  description = "The drive size in gb"
  type        = number
  default     = 40
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
  default = "192.168.1.9:5000"
}
variable "kubernetes_version" {
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
variable "private_key_path" {
  type    = string
  default = "~/.ssh/id_rsa" # ruta a la clave privada usada para SSH
}

variable "cni_manifest_url" {
  type        = string
  description = "URL of the CNI manifest to apply"
  default     = "https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
}

variable "master_count" {
  type        = number
  description = "Number of master nodes"
  default     = 3
}

variable "network_cidr" {
  type        = string
  description = "CIDR block for the network"
  default     = ""
}

variable "start_ip_offset" {
  type        = number
  description = "Starting offset for IP assignment"
  default     = 10
}
variable "worker_count" {
  type        = number
  description = "Number of worker nodes"
  default     = 2
}

variable "hostpci_id" {
  type        = string
  description = "PCI device id (e.g. 0000:01:00)"
  default     = null
}
variable "storage_spec" {
  description = "drive sizes"
  type        = list(number)
  default     = [40, 500]
}