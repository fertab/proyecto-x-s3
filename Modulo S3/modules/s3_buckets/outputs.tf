output "bucket_ids" {
  value = aws_s3_bucket.buckets[*].id
}
