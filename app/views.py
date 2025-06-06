# views.py
from controllers import get_tracking_status

def register_routes(app):
    # Ruta SOAP para consultar el estado de un paquete por tracking number
    app.add_url_rule('/soap', 'soap_tracking_status', get_tracking_status, methods=['POST'])