from flask import Flask
from .models import db
from .controllers import register_routes  # Rutas principales

def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.Config')  # Configuración de la aplicación
    
    db.init_app(app)  # Inicializa la base de datos
    register_routes(app)  # Registra las rutas del servicio SOAP


    return app
