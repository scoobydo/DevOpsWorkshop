resource "aws_subnet" "shoko_subnet-a" {
  vpc_id            = var.vpc
  tags              = { Name = "shoko-subnet-a" }
  cidr_block        = var.subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "shoko_subnet-b" {
  vpc_id            = var.vpc
  tags              = { Name = "shoko-subnet-b" }
  cidr_block        = var.subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
}

# Route Table
resource "aws_route_table" "shoko_route_table" {
  vpc_id = var.vpc
  tags   = { Name = "shoko-route_table" }

  route {
    cidr_block    = "192.168.0.0/16"
    gateway_id    = "local"
  }

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = var.gateway_id
  }
}

resource "aws_route_table_association" "subnet_a_association" {
  subnet_id      = aws_subnet.shoko_subnet-a.id
  route_table_id = aws_route_table.shoko_route_table.id
}

resource "aws_route_table_association" "subnet_b_association" {
  subnet_id      = aws_subnet.shoko_subnet-b.id
  route_table_id = aws_route_table.shoko_route_table.id
}

resource "aws_s3_bucket_policy" "shoko_bucket_policy" {
  bucket = "shoko-s3"
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_eks_access_policy_association" "user_access" {
  for_each      = toset(var.aws_iam_users)
  cluster_name  = var.cluster_name
  principal_arn = data.aws_iam_user.current_users[each.key].arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

# Output for User ARN
output "user_arn" {
  value = data.aws_iam_user.current_users["shoko-user"].arn
}