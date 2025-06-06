# run.py
from app import create_app  # Correctamente importando la función create_app desde 'app/__init__.py'

# Crear la aplicación Flask
app = create_app()

# Verificar todas las rutas registradas
print("Rutas registradas:")
for rule in app.url_map.iter_rules():
    print(f"{rule.endpoint}: {rule} ")

if __name__ == '__main__':
    app.run(debug=True)