# Importa la aplicación WSGI combinada que contiene tanto Flask como el servicio SOAP
from soap_server import application

# Importa el servidor de desarrollo de Werkzeug para correr la aplicación
from werkzeug.serving import run_simple

# Punto de entrada del script
if __name__ == '__main__':
    # Ejecuta el servidor en la dirección 0.0.0.0 (acepta conexiones externas) y en el puerto 5000
    # Usa la aplicación combinada con Flask y SOAP
    run_simple('0.0.0.0', 5000, application)
