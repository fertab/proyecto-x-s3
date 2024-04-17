 resource "aws_s3_bucket" "static_website" {
  count = length(var.buckets)

  bucket = var.buckets[count.index]
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
  
  dynamic "website" {
    for_each = var.enable_static_website ? [1] : []
    content {
      index_document = "index.html"
      error_document = "error.html"
    }
  }
}
