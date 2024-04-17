variable "enable_static_website" {
  description = "Indica si se habilita el hosting web estático en el bucket."
  type        = bool
  default     = false
}

variable "buckets" {
  description = "Nombre del bucket de S3."
  type    = list(string)
  default = []
}
