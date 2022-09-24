locals {
  aws_account_number      = var.aws_account_number
  aws_region              = var.aws_region
  lambda_function_arn     = var.lambda_fuinction_ar
  lambda_code_s3_bucket   = var.lambda_code_s3_bucket
  lambda_code_s3_key      = var.lambda_code_s3_key
  lambda_function_handler = var.lambda_function_handler
  lambda_iam_role_name    = var.lambda_iam_role_name
}

resource "aws_lambda_function" "lambda_function" {
  function_name = local.function_name
  s3_bucket     = local.lambda_code_s3_bucket
  s3_key        = local.lambda_code_s3_key
  handler       = local.lambda_function_handler
  role          = aws_iam_role.lambda_iam_role
}

resource "aws_iam_role" "lambda_iam_role" {
  name = local.lambda_iam_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  #   TODO: get the correct role policy for this
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
