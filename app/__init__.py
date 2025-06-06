from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

# Inicializar la base de datos y la migración
db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.Config')  # Configuración de la aplicación
    
    # Inicializar la base de datos y la migración
    db.init_app(app)
    migrate.init_app(app, db)

    # Aquí registras otras rutas y configuraciones
    return app
