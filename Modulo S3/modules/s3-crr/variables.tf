variable "source_region" {
  type = string
  description = "AWS Region for the source bucket"
}

variable "dest_region" {
  type = string
  description = "AWS region for the destination bucket"
}

variable "source_bucket_name" {
  type = string
  description = "Name for the source s3 bucket"
}

variable "replicate_prefix" {
  type = string
  description = "Prefix to replicate, default \"\" for all objects. Note if specifying, must end in a /"
  default = ""
}

variable "dest_bucket_name" {
  type = string
  description = "Name for the destination s3 bucket"
}

variable "create_dest_bucket" {
  type = string
  description = "Boolean for whether this module should create the destination bucket"
  default = "true"
}

variable "reaplication_name" {
  type = string
  description = "Short name to describe this replication"
}

variable "priority" {
  description = "The priority associated with the rule"
  default = 0
}