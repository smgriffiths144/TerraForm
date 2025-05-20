

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucketg022566422092"
  #acl    = "private"

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

module "website_s3_bucket_v2" {
  source = "./modules/s3"

  bucket_name = "022566422092-porthmadoggo-v2"

  tags = {
    Terraform   = "true"
    Environment = "production"
    Module = "local"
  }
}

module "website_s3_bucket_v3" {
  source = "./modules/s3"

  bucket_name = "022566422092-porthmadoggo-v3"

  tags = {
    Terraform   = "true"
    Environment = "devvvvvyyyyyy"
    Module = "local"
  }
}

module "s3_bucket_remote_module" {
  #source = "git@github.com:smgriffiths144/terraform-modules.git"
  source = "git::https://github.com/smgriffiths144/terraform-modules.git"#?ref=v1.5.0"
  
  bucket_name = "022566422092-test-remote-module"
  q_name = "remoteqname"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Module = "remote"
  }
}