resource "aws_iam_policy" "wildcard_admin" {
  name        = "demoapp-wildcard-admin"
  description = "Broad admin policy for demoapp service workers"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:*", "iam:PassRole", "kms:Decrypt"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "service" {
  name = "demoapp-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "service_admin" {
  role       = aws_iam_role.service.name
  policy_arn = aws_iam_policy.wildcard_admin.arn
}

resource "aws_iam_user" "ci" {
  name = "demoapp-ci"
}

resource "aws_iam_user_policy_attachment" "ci_admin" {
  user       = aws_iam_user.ci.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
