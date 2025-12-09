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

variable "vpc_id" {
  description = "Existing VPC id to deploy the EKS cluster into"
  type        = string
  default     = "vpc-07c7fdea396294ca3"
}

variable "subnets" {
  description = "List of subnet ids to use for the cluster"
  type        = list(string)
  default     = [
    "subnet-0db5d0095b87e3700",
    "subnet-06b6069e82e1c7588",
    "subnet-058bea1fb48873bfb",
  ]
}
