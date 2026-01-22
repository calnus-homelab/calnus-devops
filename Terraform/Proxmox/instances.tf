variable "network_cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "master_count" {
  type    = number
  default = 1
}

variable "worker_count" {
  type    = number
  default = 3
}

# where to start allocating host numbers inside the CIDR (avoid .0,.1,.255)
variable "start_ip_offset" {
  type    = number
  default = 60
}
