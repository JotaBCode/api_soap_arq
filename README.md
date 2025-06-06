
# API SOAP Project

Este proyecto es una **API SOAP** para rastrear el estado de paquetes. Está construido con **Flask** como framework web, **SQLAlchemy** para manejar la base de datos, y **PostgreSQL** como sistema gestor. Toda la información de los paquetes y sus eventos se almacena en esta base de datos.

## ¿Qué hace esta API?

Permite consultar el estado de un paquete mediante un número de seguimiento. Al enviar una solicitud tipo SOAP, la API responde con información sobre la ubicación actual del paquete, su estado y un historial de eventos.

## Tecnologías utilizadas

- **Flask** para definir rutas y levantar el servidor web.
- **SQLAlchemy** como ORM.
- **PostgreSQL** como base de datos relacional.
- **lxml** para manipular XML, ya que SOAP se basa en este formato.

## Requisitos previos

Antes de ejecutar el proyecto, es necesario contar con:

- Python (versión 3.7 o superior recomendada).
- PostgreSQL instalado y corriendo.
- Pip para instalar paquetes de Python.

## Instalación y ejecución

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu_usuario/api_soap_arq.git
```

### 2. Ingresar al directorio del proyecto

```bash
cd api_soap_arq
```

### 3. Crear un entorno virtual (opcional, pero recomendado)

```bash
python -m venv venv
```

### 4. Activar el entorno virtual (en Windows)

```bash
venv\Scripts\activate
```

### 5. Instalar las dependencias del proyecto

```bash
pip install Flask==2.1.1
pip install Flask-SQLAlchemy==2.5.1
pip install SQLAlchemy==1.4.25
pip install lxml==5.4.0
pip install psycopg2==2.9.10
```

### 6. Configurar la base de datos

Asegurarse de tener PostgreSQL funcionando y crear una base de datos llamada `trackingsystem`.

Si se utiliza Flask-Migrate, ejecutar los siguientes comandos para generar y aplicar las migraciones:

```bash
flask db init
flask db migrate
flask db upgrade
```

En caso contrario, también se puede optar por crear manualmente las tablas `Package` y `TrackingEvent`.

### 7. Ejecutar la aplicación

```bash
python run.py
```

Con esto, la API estará disponible en `http://127.0.0.1:5000/`.

---

## Cómo probar la API

### URL del servicio SOAP

- **URL:** `http://127.0.0.1:5000/soap`
- **Método:** POST
- **Content-Type:** `text/xml`

### Usar Postman

1. Abrir Postman y crear una nueva solicitud.
2. Seleccionar el método `POST` y usar la URL `http://127.0.0.1:5000/soap`.
3. En la pestaña **Headers**, añadir:
```
Key: Content-Type
Value: text/xml
```
4. En la pestaña **Body**, seleccionar `raw` y pegar el siguiente XML:

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:log="http://logistica.com/ws/tracking">
   <soapenv:Body>
      <log:GetTrackingStatus>
         <log:trackingNumber>PE1234567890</log:trackingNumber>
      </log:GetTrackingStatus>
   </soapenv:Body>
</soapenv:Envelope>
```

5. Hacer clic en **Send** para recibir una respuesta con el estado del paquete.

### Usar SoapUI

1. Abrir SoapUI y crear un nuevo proyecto SOAP.
2. Dejar el campo "Initial WSDL" en blanco.
3. Crear una nueva solicitud con el endpoint `http://127.0.0.1:5000/soap`.
4. Pegar el XML de ejemplo en la pestaña de solicitud.
5. Verificar que el método sea POST y que el encabezado `Content-Type` esté en `text/xml`.
6. Ejecutar la solicitud para visualizar la respuesta.
