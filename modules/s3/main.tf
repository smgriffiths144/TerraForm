resource "aws_s3_bucket" "s3_bucket_module_made" {
  bucket = var.bucket_name
  tags = var.tags
  versioning = {
    enabled = true
  }
}



