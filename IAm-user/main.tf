IAM User with Policy and Bucket Versioning 

provider "aws" {
  region = "us-east-1"
}

# IAM User
resource "aws_iam_user" "my_user" {
  name = "dev-user"
}

# IAM Policy for S3 full access
resource "aws_iam_user_policy" "my_user_policy" {
  name = "S3FullAccess"
  user = aws_iam_user.my_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-secure-versioned-bucket-12345" # must be globally unique
  tags = {
    Name        = "MySecureBucket"
    Environment = "Dev"
  }
}

# Enable Versioning on S3 Bucket
resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

