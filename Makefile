venv:
	python3 -m venv .venv
	. .venv/bin/activate && pip install -r requirements.txt

train:
	python src/train.py --output models/model.pkl

serve:
	python src/serve.py --model-path models/model.pkl

lint:
	python -m pyflakes src || true

test:
	pytest -q

build-docker:
	docker build -t mlops-assignment:latest .

run-docker:
	docker run -p 5000:5000 --rm -v $(pwd)/models:/app/models mlops-assignment:latest
