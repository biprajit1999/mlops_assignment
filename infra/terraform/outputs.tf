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

output "ecr_image_uri" {
  description = "The image URI (including tag) that will be deployed to EKS"
  value       = var.ecr_image_uri
}

output "lb_role_arn" {
  description = "IAM role ARN for AWS Load Balancer Controller service account"
  value       = aws_iam_role.aws_lb_controller.arn
}
