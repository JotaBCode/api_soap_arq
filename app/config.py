# config.py
import os

class Config:
    # Base de datos
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'postgresql://postgres:12345@localhost/trackingsystem')
    SQLALCHEMY_TRACK_MODIFICATIONS = False