data "aws_iam_user" "current_users" {
  for_each = toset(var.aws_iam_users)
  user_name = each.key
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]  # Added ListBucket action
    resources = ["arn:aws:s3:::shoko-s3/*"]

    principals {
      type        = "AWS"
      identifiers = var.allowed_principals
    }
  }

  statement {
    actions = ["s3:ListBucket"]  # Allow listing the bucket
    resources = ["arn:aws:s3:::shoko-s3"]

    principals {
      type        = "AWS"
      identifiers = var.allowed_principals
    }
  }
}