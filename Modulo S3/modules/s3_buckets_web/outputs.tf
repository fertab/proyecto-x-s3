output "bucket_ids" {
  value = aws_s3_bucket.static_website[*].id
}
