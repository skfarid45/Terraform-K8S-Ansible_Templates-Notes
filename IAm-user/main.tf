IAM User with Policy


provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "my_user" {
  name = "dev-user"
}

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

