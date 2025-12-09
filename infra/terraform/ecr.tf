// ECR repository is not created by Terraform in this deployment.
// We expect an existing image URI to be provided via the `ecr_image_uri` variable
// (for example: "670880232822.dkr.ecr.ap-northeast-1.amazonaws.com/mlops:latest").

// If you prefer Terraform to manage the ECR repository, re-add an aws_ecr_repository resource here.

