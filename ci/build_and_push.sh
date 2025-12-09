#!/usr/bin/env bash
set -euo pipefail

# Helper script to build the project Docker image and push to ECR.
# Expects the following environment variables to be defined:
#  - AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION, AWS_ACCOUNT_ID
#  - ECR_REPO (defaults to "mlops-assignment")

if [ -z "${AWS_REGION:-}" ]; then
  echo "ERROR: AWS_REGION is not set. Example: ap-northeast-1"
  exit 1
fi

if [ -z "${ECR_URI:-}" ] && [ -z "${AWS_ACCOUNT_ID:-}" ]; then
  echo "ERROR: either ECR_URI or AWS_ACCOUNT_ID must be set. Example ECR_URI: 670880232822.dkr.ecr.ap-northeast-1.amazonaws.com/mlops"
  exit 1
fi

# If ECR_URI is provided, parse registry and repo. Otherwise build from AWS_ACCOUNT_ID and ECR_REPO.
if [ -n "${ECR_URI:-}" ]; then
  REGISTRY="${ECR_URI%%/*}"
  REPO="${ECR_URI#*/}"
else
  ECR_REPO_DEFAULT="mlops-assignment"
  REPO="${ECR_REPO:-$ECR_REPO_DEFAULT}"
  REGISTRY="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
fi

echo "Using ECR registry: $REGISTRY and repo: $REPO (region $AWS_REGION)"

# Ensure awscli exists
if ! command -v aws >/dev/null 2>&1; then
  echo "aws CLI not found; trying to install via pip3"
  pip3 install --no-cache-dir awscli
fi

echo "Ensuring ECR repository exists..."
if ! aws ecr describe-repositories --region "$AWS_REGION" --repository-names "$REPO" >/dev/null 2>&1; then
  aws ecr create-repository --region "$AWS_REGION" --repository-name "$REPO"
fi

echo "Logging into ECR..."
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$REGISTRY"

IMAGE_TAG="latest"
LOCAL_TAG="$REPO:$IMAGE_TAG"
ECR_TAG="$REGISTRY/$REPO:$IMAGE_TAG"

echo "Building Docker image $LOCAL_TAG"
docker build -t "$LOCAL_TAG" .


echo "Tagging image $ECR_TAG"
docker tag "$LOCAL_TAG" "$ECR_TAG"

echo "Pushing to ECR: $ECR_TAG"
docker push "$ECR_TAG"

echo "Push complete."
