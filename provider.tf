resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  
    #onfig_context=var.cluster_name
  }
}

resource "aws_iam_policy" "load_balancer_controller" {
  name        = "Load_balancer_controller_shahar"  
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = data.aws_iam_policy_document.load_balancer_controller.json
}

resource "aws_iam_role_policy_attachment" "load_balancer_controller_attachment" {
  policy_arn = aws_iam_policy.load_balancer_controller.arn
  role       = aws_iam_role.eks_cluster_role.name
}