variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "mlops-assignment-eks"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  # default region set to ap-northeast-1 per user request
  default     = "ap-northeast-1"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.small"
}
