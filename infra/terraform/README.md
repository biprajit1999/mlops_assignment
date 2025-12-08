Terraform infra for EKS + ECR (minimal, destroyable)

Quick commands (run from this folder):

1. Initialize
   terraform init

2. Plan
   terraform plan -var="aws_region=us-east-1"

3. Apply (creates VPC, EKS cluster, node group, ECR repository)
   terraform apply -auto-approve -var="aws_region=us-east-1"

4. Destroy (removes all created resources)
   terraform destroy -auto-approve -var="aws_region=us-east-1"

Notes:
- This uses terraform-aws-modules/eks which creates several AWS resources (VPC, subnets, security groups).
- Keep region as desired; resource types were chosen for minimal cost (small instance type, 1 node).
- Always run `terraform destroy` from here to remove resources safely.
