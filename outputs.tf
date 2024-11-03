output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_version" {
  description = "The version of the EKS cluster."
  value       = module.eks.cluster_version
}

output "user_arns" {
  description = "The ARNs of the IAM users."
  value       = [for user in data.aws_iam_user.current_users : user.arn]
}