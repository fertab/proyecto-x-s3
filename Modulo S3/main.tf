provider "aws" {
  region = var.virginia
  alias = "Virginia"
}

locals {
  bucket_count = 1
}

module "buckets" {
  source = "./modules/s3_buckets"
  bucket_names = [for i in range(local.bucket_count) : "bucket-proyecto-x-${i}"]
}

module "buckets_web" {
  source       = "./modules/s3_buckets_web"
  buckets      = [for i in range(local.bucket_count) : "bucket-proyecto-x-${var.virginia}-${i}"]
  enable_static_website = true
}

module "s3-crr" {
    source = "./modules/s3-crr"
    source_bucket_name = "proyecto-x-bucket-source1"
    source_region = "us-east-1"
    dest_bucket_name = "proyecto-x-bucket-dest1"
    dest_region = "us-west-2"
    reaplication_name = "replication-proyecto-x"
}