resource "aws_ecr_repository" "app" {
  name                 = "mlops-assignment"
  image_tag_mutability = "MUTABLE"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
