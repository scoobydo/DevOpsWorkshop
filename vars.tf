variable "vpc" {
    description = "work area vpc"
    type = string
    default = "vpc-01b834daa2d67cdaa"
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
  default     = ["192.168.20.0/24", "192.168.21.0/24"]
}
variable "region" {
  type        = string
  default     = "eu-west-1"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "gateway_id" {
  type        = string
  default     = "nat-0440e3c0e49d26497"
}

variable "aws_iam_users" {
  type        = list(string)
  default     = ["shahar-user"]  
 }

variable "cluster" {
  type        = string
  default     = "shahar-cluster"   
 }

variable "cluster_version" {
  type        = string
  default     = "1.29" 
}
