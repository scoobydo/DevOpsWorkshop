variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"  # Default region
}

variable "vpc" {
  description = "The VPC ID where resources will be deployed"
  type        = string
  default     = "vpc-12345678"  # Replace with your default VPC ID
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for subnets"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.2.0/24"]  # Example CIDR blocks
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]  # Example AZs
}

variable "gateway_id" {
  description = "The ID of the NAT Gateway"
  type        = string
  default     = "nat-12345678"  # Replace with your default NAT Gateway ID
}

variable "aws_iam_users" {
  description = "List of IAM users who will have access to the EKS cluster"
  type        = list(string)
  default     = ["user1", "user2"]  # Example IAM users
}

variable "allowed_principals" {
  description = "List of AWS principals allowed to access the S3 bucket"
  type        = list(string)
  default     = ["arn:aws:iam::123456789012:root"]  # Replace with your allowed principals
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"  # Default cluster name
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.21"  # Default EKS version
}