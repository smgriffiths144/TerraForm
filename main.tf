terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.00"
    }
  }

  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "022566422092-terraform-state-gh-test"
    key            = "states/github-test/key"
    region         = "us-east-1"
    dynamodb_table = "022566422092-terraform-state-gh-test"
    encrypt        = true
  }
}

provider "aws" {
  #profile = "default"
  region = "us-east-1"
}
/*
resource "tls_private_key" "keypair" {
  algorithm = "RSA"
}

resource "local_file" "privatekey" {
  content  = tls_private_key.keypair.private_key_pem
  filename = "key1.pem"
}

resource "aws_key_pair" "deployer" {
  key_name   = "key1.pem"
  public_key = tls_private_key.keypair.public_key_openssh
}
*/