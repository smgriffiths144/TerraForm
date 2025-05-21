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

module "website_s3_bucket_new_stuff" {
  source = "./modules/s3"

  bucket_name = "022566422092-new-stuff"

  tags = {
    Terraform   = "true"
    Environment = "devvvvvyyyyyyvvv"
    Module      = "local"
  }
}