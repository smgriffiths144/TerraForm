/*
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
*/
resource "aws_s3_bucket" "example2" {
  bucket = "my-tf-test-bucket-022566422092"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}