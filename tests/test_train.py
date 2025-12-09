import os
from src import train

def test_training_creates_model(tmp_path):
    out = tmp_path / "model.pkl"
    train.train(str(out))
    assert out.exists()
