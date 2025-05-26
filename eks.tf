resource "aws_security_group" "eks_api_access" {
  name        = "eks-api-access"
  description = "Allow access to EKS cluster endpoint from EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks =  ["192.168.0.0/16"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.35.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = aws_vpc.main.id
  subnet_ids      = aws_subnet.private[*].id

  create_cloudwatch_log_group = false
  
  cluster_addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = {}
    amazon-cloudwatch-observability = {
      most_recent = true  
    }
  }


  
  eks_managed_node_groups = {
    default = {
      name           = "worker-group"
      instance_types = [var.eks_node_instance_type]
      min_size       = 1
      max_size       = 1
      desired_size   = 1

      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"        
      }

    }
  }

  
  cluster_additional_security_group_ids = [aws_security_group.eks_api_access.id]
}

resource "aws_eks_access_entry" "admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::443370696892:user/AdminRole"  
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.admin.principal_arn

  access_scope {
    type = "cluster"
  }
}

