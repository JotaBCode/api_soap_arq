# app/controllers.py
from flask import request, Response
from app import db  # Importamos la instancia db desde models.py
from app.models import Package, TrackingEvent  # Importamos los modelos
import xml.etree.ElementTree as ET

# Definir la función soap_tracking_status
def soap_tracking_status():
    # Verificar que el contenido de la solicitud es XML
    if request.content_type != 'text/xml':
        return Response('<error>Content-Type must be text/xml</error>', content_type='text/xml', status=415)

    # Obtener el cuerpo de la solicitud XML
    body = request.data

    # Parsear el XML
    try:
        root = ET.fromstring(body)
        tracking_number = root.find('.//log:trackingNumber', namespaces={'log': 'http://logistica.com/ws/tracking'}).text
        if not tracking_number:
            raise ValueError("Tracking number is missing in the XML")
    except ET.ParseError:
        return Response('<error>Invalid XML format</error>', content_type='text/xml', status=400)
    except ValueError as e:
        return Response(f'<error>{str(e)}</error>', content_type='text/xml', status=400)

    # Consultar el paquete en la base de datos
    package = Package.query.filter_by(tracking_number=tracking_number).first()

    if not package:
        error_message = f"Package with tracking number '{tracking_number}' not found."
        return Response(f'<error>{error_message}</error>', content_type='text/xml', status=404)

    # Depuración: Verificar si hemos encontrado el paquete
    print(f"Found package: {package.tracking_number}, Package ID: {package.id}")

    # Realizar la consulta SQL explícita para obtener los eventos
    query = """
    SELECT te.id, te.event_date, te.description, te.location 
    FROM trackingevent te
    INNER JOIN package p ON te.package_id = p.id
    WHERE p.tracking_number = :tracking_number
    """

    # Ejecutar la consulta SQL directamente
    events = db.session.execute(query, {'tracking_number': tracking_number}).fetchall()

    # Crear la respuesta SOAP
    envelope = ET.Element("soapenv:Envelope", xmlns_soapenv="http://schemas.xmlsoap.org/soap/envelope/", xmlns_log="http://logistica.com/ws/tracking")
    body = ET.SubElement(envelope, "soapenv:Body")
    response = ET.SubElement(body, "log:GetTrackingStatusResponse")
    
    # Agregar los datos del paquete al XML
    status = ET.SubElement(response, "log:status")
    status.text = package.status
    
    current_location = ET.SubElement(response, "log:currentLocation")
    current_location.text = package.current_location or "No data"
    
    estimated_delivery_date = ET.SubElement(response, "log:estimatedDeliveryDate")
    estimated_delivery_date.text = str(package.estimated_delivery_date)

    # Agregar history (Eventos del paquete)
    history = ET.SubElement(response, "log:history")

    # Si hay eventos, agregarlos a history
    if len(events) > 0:
        for event in events:
            event_elem = ET.SubElement(history, "log:event")
            event_date = ET.SubElement(event_elem, "log:date")
            event_date.text = str(event[1])  # Usamos el índice 1 para acceder a 'event_date'
            
            description = ET.SubElement(event_elem, "log:description")
            description.text = event[2]  # Usamos el índice 2 para acceder a 'description'
            
            location = ET.SubElement(event_elem, "log:location")
            location.text = event[3]  # Usamos el índice 3 para acceder a 'location'
    else:
        history.text = "No events found"  # Si no hay eventos, se agrega este texto

    # Convertir el árbol XML a cadena y devolverlo
    response_xml = ET.tostring(envelope, encoding="unicode", method="xml")
    
    return Response(response_xml, content_type='text/xml')
