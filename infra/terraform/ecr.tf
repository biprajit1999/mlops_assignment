resource "aws_ecr_repository" "app" {
  name                 = "mlops-assignment"
  image_tag_mutability = "MUTABLE"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "mlops"
    Owner       = "biprajit1999"
    Name        = "mlops-assignment-ecr"
  }
}
