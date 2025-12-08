module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  # create a small VPC and cluster for minimal cost
  create_vpc = true

  node_groups = {
    default = {
      desired_capacity = 1
      min_capacity     = 1
      max_capacity     = 2
      instance_types   = [var.node_instance_type]
    }
  }

  manage_aws_auth = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
