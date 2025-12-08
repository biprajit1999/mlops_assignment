import pandas as pd
from sklearn.model_selection import train_test_split


def load_and_split(df=None, test_size=0.2, random_state=42):
    if df is None:
        raise ValueError("DataFrame must be provided")
    X = df.drop(columns=["target"])
    y = df["target"]
    return train_test_split(X, y, test_size=test_size, random_state=random_state)
