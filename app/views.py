# app/views.py
from app.controllers import soap_tracking_status  # Asegúrate de importar la función correcta

def register_routes(app):
    # Ruta SOAP para consultar el estado de un paquete por tracking number
    app.add_url_rule('/soap', 'soap_tracking_status', soap_tracking_status, methods=['POST'])

