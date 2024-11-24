data "aws_iam_user" "current_users" {
  for_each = toset(var.aws_iam_users)
  user_name = each.key
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "AllowSpasi"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [for user in data.aws_iam_user.current_users : user.arn]  
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:DeleteObject",
      #"s3:PutObjectAcl",  # Add this if you need to set ACLs
      #"s3:GetBucketLocation"  # Add this if needed
]
    
    resources = [
      "arn:aws:s3:::shahar-s3",
      "arn:aws:s3:::shahar-s3/*"
    ]
  }
}

data "aws_iam_policy_document" "load_balancer_controller" {
  statement {
    actions = [
      "elasticloadbalancing:*",
      "ec2:*",
      "iam:PassRole",
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "acm:RequestCertificate",
      "acm:DeleteCertificate",
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
      "route53:ListHostedZones",
      "route53:GetHostedZone",
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
    ]
    resources = ["*"]
  }
}

# Data block to reference the existing Route 53 Hosted Zone
data "aws_route53_zone" "main" {
  name = var.domain_name
}