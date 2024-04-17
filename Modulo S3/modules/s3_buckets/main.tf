resource "aws_s3_bucket" "buckets" {
  count = length(var.bucket_names)

  bucket = var.bucket_names[count.index]
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

