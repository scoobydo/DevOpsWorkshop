module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.0"

  cluster_name                  = var.cluster_name
  cluster_version               = var.cluster_version
  vpc_id                        = var.vpc
  subnet_ids                    = [aws_subnet.shoko_subnet-a.id, aws_subnet.shoko_subnet-b.id]
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = { version = "v1.11.1-eksbuild.4" }
    aws-ebs-csi-driver = { version = "v1.35.0-eksbuild.1" }
  }

  eks_managed_node_groups = {
    shahar-nodegroup = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 1
      instance_type   = "t2.micro"
    }
  }

  access_entries = {
    for user_name in var.aws_iam_users : user_name => {
      principal_arn = data.aws_iam_user.current_users[user_name].arn
    }
  }
}