provider "aws" {
  region     = "us-east-1"
  access_key = "key"
  secret_key = "key"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "4oct-s3"   # must be globally unique and lowercase

  tags = {
    Name        = "4oct-s3"
    Environment = "Dev"
  }
}
