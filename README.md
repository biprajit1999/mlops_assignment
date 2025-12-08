# MLOps Assignment — Production-grade Template

This repository is a production-focused MLOps scaffold created to satisfy an end-to-end assignment. It includes:

- A reproducible training pipeline (`src/train.py`) using scikit-learn.
- Local model serving via a small Flask app (`src/serve.py`).
- Dockerfile + `docker-compose.yml` for local testing.
- GitHub Actions CI workflow for linting/tests and container build.
- Kubernetes manifests for deployment (`deploy/`).
- Examples for model registry (MLflow) tracing in training.

Quick start (local):

1. Create a venv and install requirements:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

2. Train a sample model:

```bash
python src/train.py --output models/model.pkl
```

3. Serve the model locally:

```bash
python src/serve.py --model-path models/model.pkl
# then: curl -X POST http://localhost:5000/predict -H "Content-Type: application/json" -d '{"instances": [[5.1,3.5,1.4,0.2]]}'
```

See `Makefile` for conveniences.
