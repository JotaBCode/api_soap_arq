# API SOAP Project

Este proyecto es una **API SOAP** que permite rastrear el estado de los paquetes. Está desarrollado utilizando **Flask** como framework, **SQLAlchemy** para manejar la base de datos, y **PostgreSQL** como base de datos para almacenar el estado de los paquetes y sus eventos.

## Descripción

La API permite consultar el estado de un paquete mediante el uso de un servicio **SOAP**. La aplicación incluye un servicio que permite rastrear el estado de los paquetes, su ubicación y eventos asociados. El servicio recibe solicitudes **SOAP** y responde con los detalles del estado del paquete.

## Tecnologías utilizadas

- **Flask**: Framework web en Python utilizado para crear el servicio API.
- **SQLAlchemy**: ORM utilizado para interactuar con la base de datos.
- **PostgreSQL**: Base de datos utilizada para almacenar la información sobre los paquetes.
- **lxml**: Librería de procesamiento de XML utilizada para construir y manejar la respuesta SOAP.

## Requisitos

Antes de ejecutar el proyecto, asegúrate de tener lo siguiente instalado en tu máquina:

- **Python** (preferiblemente 3.7 o superior).
- **PostgreSQL** (para la base de datos).
- **Pip** (para instalar dependencias).

## Instalación

Para instalar y ejecutar este proyecto en tu máquina local, sigue estos pasos:

### 1. Clona el repositorio

```bash
git clone https://github.com/tu_usuario/api_soap_arq.git
```

## 2. Navega al directorio del proyecto

```bash
cd api_soap_arq
```

## 3. Crea un entorno virtual (opcional pero recomendado)

```bash
python -m venv venv
```

## 4. Activa el entorno virtual

**En Windows:**

```bash
venv\Scripts\activate
```

**En Linux/MacOS:**

```bash
source venv/bin/activate
```

## 5. Instala las dependencias

```bash
pip install Flask==2.1.1
pip install Flask-SQLAlchemy==2.5.1
pip install SQLAlchemy==1.4.25
pip install lxml==5.4.0
pip install psycopg2==2.9.10
```

## 6. Configura la base de datos

Instala PostgreSQL si no lo tienes y crea una base de datos llamada `trackingsystem`.

Si estás utilizando Flask-Migrate, ejecuta:

```bash
flask db init
flask db migrate
flask db upgrade
```

Si no usas migraciones, asegúrate de que las tablas `Package` y `TrackingEvent` existan.

## 7. Ejecuta la aplicación

```bash
python run.py
```

La aplicación estará corriendo en `http://127.0.0.1:5000/`.

## Rutas de la API

### /soap (POST)

Esta ruta maneja solicitudes SOAP para consultar el estado de paquetes mediante número de seguimiento.

**Endpoint completo:** `http://127.0.0.1:5000/soap`  
**Método:** `POST`  
**Tipo de contenido (Content-Type):** `text/xml`

### Cómo consumir en Postman

1. Abre Postman.
2. Crea una nueva petición con método `POST`.
3. En la URL coloca: `http://127.0.0.1:5000/soap`
4. Ve a la pestaña **Headers** y agrega:
   - `Content-Type: text/xml`
5. Ve a la pestaña **Body**, selecciona `raw`, y pega el siguiente XML:

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:log="http://logistica.com/ws/tracking">
   <soapenv:Body>
      <log:GetTrackingStatus>
         <log:trackingNumber>PE1234567890</log:trackingNumber>
      </log:GetTrackingStatus>
   </soapenv:Body>
</soapenv:Envelope>
```

6. Haz clic en **Send** para obtener la respuesta del servicio SOAP.

### Ejemplo de respuesta SOAP

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:log="http://logistica.com/ws/tracking">
    <soapenv:Body>
        <log:GetTrackingStatusResponse>
            <log:status>En tránsito</log:status>
            <log:currentLocation>Lima</log:currentLocation>
            <log:estimatedDeliveryDate>2025-04-15</log:estimatedDeliveryDate>
            <log:history>
                <log:event>
                    <log:date>2025-04-05 12:00:00</log:date>
                    <log:description>Paquete recibido en bodega central</log:description>
                    <log:location>Lima</log:location>
                </log:event>
                <log:event>
                    <log:date>2025-04-07 00:00:00</log:date>
                    <log:description>Salida hacia Lima</log:description>
                    <log:location>Arequipa</log:location>
                </log:event>
            </log:history>
        </log:GetTrackingStatusResponse>
    </soapenv:Body>
</soapenv:Envelope>
```
