import os
from flask import send_file

def register_routes(app):
    from app.controllers.controllers import soap_tracking_status

    app.add_url_rule('/soap', 'soap_tracking_status', soap_tracking_status, methods=['POST'])

    # Ruta para servir el archivo WSDL correctamente
    @app.route('/wsdl', methods=['GET'])
    def get_wsdl():
        wsdl_path = os.path.join(os.path.dirname(__file__), 'wsdl', 'tracking.wsdl')
        return send_file(wsdl_path, mimetype='text/xml')
