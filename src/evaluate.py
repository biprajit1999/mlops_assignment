import joblib
import numpy as np
from sklearn.metrics import accuracy_score


def evaluate(model_path, X, y):
    model = joblib.load(model_path)
    preds = model.predict(X)
    return accuracy_score(y, preds)


if __name__ == "__main__":
    print("Use this module from tests or notebooks")
