import joblib
import numpy as np


def predict(instances, model_path="models/model.pkl"):
    model = joblib.load(model_path)
    arr = np.array(instances)
    return model.predict(arr).tolist()


if __name__ == "__main__":
    print(predict([[5.1,3.5,1.4,0.2]]))
