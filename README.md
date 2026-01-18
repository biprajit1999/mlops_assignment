# MLOps Assignment — Production-grade Template

This repository is a production-focused MLOps scaffold created to satisfy an end-to-end assignment. It includes:

- A reproducible training pipeline (`src/train.py`) using scikit-learn.
- Local model serving via a small Flask app (`src/serve.py`).
- Dockerfile + `docker-compose.yml` for local testing.
- GitHub Actions CI workflow for linting/tests and container build.
- Kubernetes manifests for deployment (`deploy/`).
- Examples for model registry (MLflow) tracing in training.

