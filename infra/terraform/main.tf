module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  # Use a release that accepts the `create_vpc`, `node_groups` and `manage_aws_auth` inputs
  # (module API changed in later major versions). Pin to v18.x for compatibility.
  # Pin to a stable older release that accepts these inputs
  version = "~> 16.0"

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
    Project     = "mlops"
    Owner       = "biprajit1999"
  }
}
