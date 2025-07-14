provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bad_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"
}

resource "aws_security_group" "bad_sg" {
  name        = "open-sg"
  description = "Security group with open ingress"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

