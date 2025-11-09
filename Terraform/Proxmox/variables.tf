variable "minio_access_key" {
  type      = string
  description = "MinIO access key (se lee desde TF_VAR_minio_access_key)"
  sensitive = true
}

variable "minio_secret_key" {
  type      = string
  sensitive = true
}