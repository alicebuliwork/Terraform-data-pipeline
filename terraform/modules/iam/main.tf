resource "aws_iam_policy" "terraform_policy" {
  name = "terraform-exec-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:*",
          "iam:PassRole",
          "iam:CreateRole",
          "iam:AttachRolePolicy"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_user_policy_attachment" "attach" {
  user       = var.user_name
  policy_arn = aws_iam_policy.terraform_policy.arn
}