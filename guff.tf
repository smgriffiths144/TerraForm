
resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = "production"
  }
}

resource "aws_s3_bucket" "example1" {
  bucket = "my1-tf-test-bucket-022566422092"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "example2" {
  bucket = "my2-fdgggdgdg022566422092"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "example3" {
  bucket = "my3-tf-tesvvvcvt-bucket-022566422092"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "example4" {
  bucket = "4vvvdvvdvggdgdg022566422092"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucketg022566422092"
  acl    = "private"

  #control_object_ownership = true
  #object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}