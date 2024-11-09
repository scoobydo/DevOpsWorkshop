output "vpc_id" {
  value = var.vpc
}

output "subnet_ids" {
  value = [aws_subnet.shahar_subnet-a.id, aws_subnet.shahar_subnet-b.id]
}

output "node_group_details" {
  value = module.eks.eks_managed_node_groups
}
# Output the EKS Cluster Role ARN
output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

# Output for User ARN
output "user_arn" {
  value = data.aws_iam_user.current_users["shahar-user"].arn
}