terraform {
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "MyInstance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"

  tags = {
    Name = "demoapp-web"
  }
}

resource "aws_instance" "WebServer2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"
}

resource "aws_s3_bucket" "ArtifactsBucket" {
  bucket = "demoapp-artifacts-prod"
}

resource "aws_iam_role" "ServiceRole" {
  name = "demoapp-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
