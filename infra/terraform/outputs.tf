output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "lb_role_arn" {
  description = "IAM role ARN for AWS Load Balancer Controller service account"
  value       = aws_iam_role.aws_lb_controller.arn
}
