module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  # Use a release that accepts the `create_vpc`, `node_groups` and `manage_aws_auth` inputs
  # (module API changed in later major versions). Pin to v18.x for compatibility.
  # Pin to a stable older release that accepts these inputs
  version = "~> 16.0"

  cluster_name    = var.cluster_name
  # Use a specific Kubernetes version confirmed supported in the region
  cluster_version = "1.32"

  # use an existing VPC and subnets supplied via variables
  vpc_id  = var.vpc_id
  subnets = var.subnets

  node_groups = {
    default = {
      desired_capacity = 1
      min_capacity     = 1
      max_capacity     = 2
      instance_types   = [var.node_instance_type]
    }
  }

  # Disable in-Terraform creation of the aws-auth configmap to avoid
  # Kubernetes provider init-time dependency on the cluster kubeconfig.
  # We'll create aws-auth after the cluster is healthy (outside Terraform
  # or in a second apply step) to avoid provider connect errors.
  manage_aws_auth = false
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "mlops"
    Owner       = "biprajit1999"
  }
}
