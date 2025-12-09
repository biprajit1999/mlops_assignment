GitLab CI / CD setup (overview)
--------------------------------

This project includes a GitLab CI pipeline (`.gitlab-ci.yml`) that trains the model, builds the Docker image including the trained model, and pushes the image to AWS ECR.

Required GitLab CI/CD variables (set in your project Settings → CI / CD → Variables):
- `AWS_ACCESS_KEY_ID` — AWS key with permissions for ECR (and later EKS/IAM/Terraform if using infra jobs).
- `AWS_SECRET_ACCESS_KEY` — AWS secret.
- `AWS_REGION` — e.g. `ap-northeast-1` (default in pipeline).
- `AWS_ACCOUNT_ID` — your AWS account number (used only if you prefer not to set `ECR_URI`).
- `ECR_URI` — full ECR URI including registry and repo (e.g. `670880232822.dkr.ecr.ap-northeast-1.amazonaws.com/mlops`). The pipeline defaults to the URI you provided.
- `KUBECONFIG` — optional, required for the `deploy_app` manual job (raw kubeconfig contents).

Runner requirements:
- The `build_and_push` job uses Docker-in-Docker (`docker:dind`). The runner must allow privileged mode and support the `docker:dind` service.
- Alternatively you can adapt the job to use a Docker executor that has access to the host Docker daemon.

How the pipeline works:
- `train` stage: installs Python dependencies and runs `python src/train.py --output models/model.pkl`. The trained `models/model.pkl` is passed as an artifact to the next stage.
- `build_and_push` stage: installs `awscli`, ensures an ECR repository exists (creates it if missing), logs into ECR, builds the Docker image, tags and pushes it to ECR as `:latest`.
- `deploy_infra` and `deploy_app` stages are present as manual jobs. `deploy_infra` is a placeholder using the Terraform container; `deploy_app` will apply the manifests in `deploy/` using the provided `KUBECONFIG` variable.

Local testing:
- You can run the training locally: `python src/train.py --output models/model.pkl`.
Use the helper script to build and push locally (requires AWS creds and Docker):

```
export AWS_REGION=ap-northeast-1
export ECR_URI=670880232822.dkr.ecr.ap-northeast-1.amazonaws.com/mlops
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
./ci/build_and_push.sh
```

Security notes:
- Do not add AWS credentials to repository files. Use GitLab CI/CD protected variables.
- Do not commit large binary files into git (Terraform providers, .terraform, etc.).
