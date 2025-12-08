from flask import Flask, request, jsonify, send_from_directory
import argparse
import joblib
from pathlib import Path
from sklearn.datasets import load_iris

app = Flask(__name__)
model = None


@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "ok"})


@app.route('/ready', methods=['GET'])
def ready():
    return jsonify({"ready": model is not None})


@app.route('/', methods=['GET'])
def root():
    return send_from_directory('static', 'index.html')


@app.route('/predict', methods=['POST'])
def predict_route():
    data = request.get_json()
    instances = data.get('instances')
    arr = instances
    preds = model.predict(arr)
    result = {"predictions": preds.tolist()}
    # add human-readable labels if iris dataset
    try:
        iris = load_iris()
        target_names = iris.target_names
        labels = [target_names[int(p)] for p in preds]
        result["labels"] = labels
    except Exception:
        pass
    # add probabilities if available
    if hasattr(model, "predict_proba"):
        probs = model.predict_proba(arr).tolist()
        result["probabilities"] = probs
    return jsonify(result)


def load_model(path):
    global model
    model = joblib.load(path)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--model-path', default='models/model.pkl')
    parser.add_argument('--host', default='0.0.0.0')
    parser.add_argument('--port', type=int, default=5000)
    args = parser.parse_args()
    if not Path(args.model_path).exists():
        raise SystemExit(f"Model not found at {args.model_path}. Run training first.")
    load_model(args.model_path)
    app.run(host=args.host, port=args.port)
