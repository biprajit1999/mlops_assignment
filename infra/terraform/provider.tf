terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # Use an older AWS provider series compatible with the EKS module code
      version = "~> 3.75"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project = "mlops"
      Owner   = "biprajit1999"
    }
  }
}
