resource "aws_subnet" "shahar_subnet-a" {
  vpc_id                  = var.vpc
  tags                     ={ Name =  "shahar-subnet-a" }
  cidr_block              = var.subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
}

resource "aws_subnet" "shahar_subnet-b" {
  vpc_id                  = var.vpc
  tags                     ={ Name =  "shahar-subnet-b" }
  cidr_block              = var.subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
}

resource "aws_route_table" "shahar_route_table" {
  vpc_id = var.vpc
  tags                     ={ Name =  "shahar-route_table" }
  
  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.gateway_id
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
  for_each = toset(var.aws_iam_users)
  cluster_name = var.cluster
  principal_arn = data.aws_iam_user.current_users[each.key].arn
  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

module "eks" {
    source          = "terraform-aws-modules/eks/aws"
    version         = "20.24.0"

    cluster_name    = var.cluster
    cluster_version = var.cluster_version

    vpc_id          = var.vpc
    subnet_ids      = [aws_subnet.shahar_subnet-a.id, aws_subnet.shahahr_subnet-b.id]

    
    eks_managed_node_group_defaults = {
      instance_types = ["t2.micro"]
      }
   
    eks_managed_node_groups = {
        shahar-nodegroup = {
            desired_capacity = 2
            max_capacity     = 2
            min_capacity     = 1

            instance_type   = "t2.micro"
        }
    }

    
    }

    

