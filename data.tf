data "aws_iam_user" "current_users" {
  for_each = toset(var.aws_iam_users)
  user_name = each.value
}
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "AllowSpasi"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.aws_iam_users
    }

    actions = [
      "s3:GetObject",    
      "s3:PutObject",    
      "s3:ListBucket",   
      "s3:DeleteObject"  
    ]
    
    resources = [
      "arn:aws:s3:::shahar-s3",
      "arn:aws:s3:::shahar-s3/*"
    ]
  }
}