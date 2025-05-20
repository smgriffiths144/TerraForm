

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.7.0"

  bucket = "my-s3-buc44444ketg022566422092"
  #acl    = "private"

  #control_object_ownership = true
  #object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "sqs" {
  source = "terraform-aws-modules/sqs/aws"

  name = "fiforrrrrrrer"

  fifo_queue = true

  tags = {
    Environment = "dev"
  }
}

module "website_s3_bucket" {
  source = "./modules/s3"

  bucket_name = "022566422092-porthmadoggo3434"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Module      = "true"
  }
}

module "website_s3_bucket_v2" {
  source = "./modules/s3"

  bucket_name = "022566422092-porthmadoggo-v2"

  tags = {
    Terraform   = "true"
    Environment = "production"
    Module      = "local"
  }
}

module "website_s3_bucket_v3" {
  source = "./modules/s3"

  bucket_name = "022566422092-porthmadoggo-v3"

  tags = {
    Terraform   = "true"
    Environment = "devvvvvyyyyyyvvv"
    Module      = "local"
  }
}

module "s3_bucket_remote_module" {
  source = "git::https://github.com/smgriffiths144/terraform-modules.git" #?ref=v1.6.0"

  bucket_name = "022566422092-test-remote-module"
  q_name      = "remoteqname"
  #q2_name           = "remoteq2nam"
  #name              = "cwlog-test"
  #retention_in_days = "1"

  tags = {
    Terraform   = "truevvvv"
    Environment = "devvvvv"
    Module      = "remotevvvv"

  }
}