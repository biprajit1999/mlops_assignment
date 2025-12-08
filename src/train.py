import argparse
import joblib
import os
import mlflow
from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score


def train(output_path="models/model.pkl"):
    data = load_iris()
    X, y = data.data, data.target
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    clf = RandomForestClassifier(n_estimators=100, random_state=42)
    clf.fit(X_train, y_train)
    preds = clf.predict(X_test)
    acc = accuracy_score(y_test, preds)

    os.makedirs(os.path.dirname(output_path) or '.', exist_ok=True)
    joblib.dump(clf, output_path)

    try:
        mlflow.log_metric("accuracy", acc)
        mlflow.sklearn.log_model(clf, "model")
    except Exception:
        # MLflow may not be configured locally — ignore gracefully
        pass

    print(f"Trained model saved to {output_path}, accuracy={acc:.4f}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default="models/model.pkl")
    args = parser.parse_args()
    train(args.output)
