#trivy:ignore:AVD-AWS-0090 <- HERE
#trivy:ignore:AVD-AWS-0094 <- HERE
#trivy:ignore:s3-bucket-logging <- HERE
module "website_s3_bucket_v3" {
  source = "./modules/s3"

  bucket_name = "022566422092-porthmadoggo-v3"

  tags = {
    Terraform   = "true"
    Environment = "devwwwww"
    Module      = "local"
  }
}

#trivy:ignore:AVD-AWS-0090 <- HERE
#trivy:ignore:AVD-AWS-0094 <- HERE
#trivy:ignore:s3-bucket-logging <- HERE
module "s3_bucket_remote_module" {
  source = "git::https://github.com/smgriffiths144/terraform-modules.git" #?ref=v1.6.0"

  bucket_name = "022566422092-alb-access-logs"
  q_name      = "remoteqname"
  #q2_name           = "remoteq2nam"
  #name              = "cwlog-test"
  #retention_in_days = "1"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Module      = "remote"

  }
}
