

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

module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"

  name = "fifo"

  fifo_queue = true

  tags = {
    Environment = "dev"
  }
}

module "website_s3_bucket" {
  source = "./modules/s3"

  bucket_name = "022566422092-porthmadoggo"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Module = "true"
  }
}
