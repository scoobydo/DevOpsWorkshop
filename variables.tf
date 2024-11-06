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
  default     = "nat-0440e3c0e49d2649"  
}

variable "aws_iam_users" {
  description = "List of IAM users who will have access to the EKS cluster"
  type        = list(string)
  default     = ["shahar-user"]  
}

variable "allowed_principals" {
  description = "List of AWS principals allowed to access the S3 bucket"
  type        = list(string)
  default     = ["arn:aws:iam::123456789012:root"]  # Replace with your allowed principals
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "shahar-clusterr"  
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.21"  # Default EKS version
}