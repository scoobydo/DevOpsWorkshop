resource "aws_subnet" "shahar_subnet-a" {
  vpc_id            = var.vpc
  tags              = { Name = "shahar-subnet-a" }
  cidr_block        = var.subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "shahar_subnet-b" {
  vpc_id            = var.vpc
  tags              = { Name = "shahar-subnet-b" }
  cidr_block        = var.subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
}

# Route Table
resource "aws_route_table" "shahar_route_table" {
  vpc_id = var.vpc
  tags   = { Name = "shahar-route_table" }

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
  subnet_id      = aws_subnet.shahar_subnet-a.id
  route_table_id = aws_route_table.shahar_route_table.id
}

resource "aws_route_table_association" "subnet_b_association" {
  subnet_id      = aws_subnet.shahar_subnet-b.id
  route_table_id = aws_route_table.shahar_route_table.id
}

resource "aws_s3_bucket_policy" "shahar_bucket_policy" {
  bucket = "shahar-s3"
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

# Create an A record for the www subdomain
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name     = "shahar.${var.domain_name}"
  type     = "CNAME"
  ttl      = 60
  records  = ["a0b4d551fdfed4341b65ca9886c97794-d5e704ccacabd7c1.elb.eu-west-1.amazonaws.com"]
}

