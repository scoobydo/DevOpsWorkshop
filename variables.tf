variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"  # Default region
}

variable "vpc" {
  description = "The VPC ID where resources will be deployed"
  type        = string
  default     = "vpc-01b834daa2d67cdaa"  
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for subnets"
  type        = list(string)
  default     = ["192.168.20.0/24", "192.168.21.0/24"]  
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]  
}

variable "gateway_id" {
  description = "The ID of the NAT Gateway"
  type        = string
  default     = "nat-0440e3c0e49d26497"  
}

variable "aws_iam_users" {
  description = "List of IAM users who will have access to the EKS cluster"
  type        = list(string)
  default     = ["shahar-user"]  
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "shahar-cluster"  
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.29"  
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for the load balancer"
  type        = string
  default     = "arn:aws:acm:eu-west-1:730335218716:certificate/8f4eeeea-9a1d-443c-a8c8-4de7f8b19aec"
}