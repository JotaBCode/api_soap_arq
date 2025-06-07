# Importación de librerías de Spyne para crear servicios SOAP
from spyne import Application, rpc, ServiceBase, Unicode
from spyne.protocol.soap import Soap11
from spyne.server.wsgi import WsgiApplication

# Importación de Flask y herramientas de integración con WSGI
from flask import Flask, request
from werkzeug.middleware.dispatcher import DispatcherMiddleware

# Importación de la aplicación Flask y la base de datos
from app import create_app, db

# Importación de los modelos desde el archivo models.py
from app.models.models import Package, TrackingEvent

# Definición del servicio SOAP
class TrackingService(ServiceBase):

    # Método SOAP expuesto: recibe un trackingNumber y devuelve una cadena
    @rpc(Unicode, _returns=Unicode)
    def GetTrackingStatus(ctx, trackingNumber):
        # Consulta en la base de datos el paquete correspondiente al número de rastreo
        package = Package.query.filter_by(tracking_number=trackingNumber).first()

        # Si no se encuentra el paquete, devolver mensaje de error
        if not package:
            return "Package not found"

        # Si se encuentra, construir y devolver el estado del paquete
        response = (
            f"Status: {package.status}, "
            f"Location: {package.current_location}, "
            f"Estimated Delivery: {package.estimated_delivery_date}"
        )
        return response

# Crear la aplicación SOAP con Spyne
soap_app = Application(
    [TrackingService],                       # Servicios disponibles (en este caso solo uno)
    tns='http://logistica.com/ws/tracking', # Espacio de nombres (namespace) para el WSDL
    in_protocol=Soap11(validator='lxml'),   # Protocolo de entrada SOAP 1.1 validado con lxml
    out_protocol=Soap11()                   # Protocolo de salida SOAP 1.1
)

# Crear el servidor WSGI que ejecuta el servicio SOAP
soap_wsgi_app = WsgiApplication(soap_app)

# Crear la aplicación Flask principal (para rutas REST, base de datos, etc.)
flask_app = create_app()

# Usar DispatcherMiddleware para combinar la aplicación Flask con la aplicación SOAP
# Las peticiones a /soap serán manejadas por el servicio SOAP
application = DispatcherMiddleware(flask_app, {
    '/soap': soap_wsgi_app  # El endpoint SOAP está disponible en /soap y el WSDL en /soap?wsdl
})
