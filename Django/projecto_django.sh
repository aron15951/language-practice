#!/bin/bash

# Solicitar nombre del proyecto y de la aplicación
read -p "Ingrese el nombre del proyecto Django: " project_name
read -p "Ingrese el nombre de la aplicación Django: " app_name

# Crear y activar entorno virtual
python3 -m venv venv
source venv/bin/activate

# Instalar dependencias
pip install django djangorestframework django-cors-headers

# Crear proyecto Django
django-admin startproject $project_name
cd $project_name

# Crear aplicación
python manage.py startapp $app_name

# Configurar settings.py
sed -i "s/INSTALLED_APPS = \[/INSTALLED_APPS = [\n    'rest_framework',\n    'corsheaders',\n    '$app_name',/" $project_name/settings.py
sed -i "s/MIDDLEWARE = \[/MIDDLEWARE = [\n    'corsheaders.middleware.CorsMiddleware',/" $project_name/settings.py
echo "CORS_ALLOW_ALL_ORIGINS = True" >> $project_name/settings.py

# Crear directorio para las migraciones si no existe
mkdir -p $app_name/migrations

# Crear archivo __init__.py en el directorio de migraciones
touch $app_name/migrations/__init__.py

# Realizar migraciones
python manage.py makemigrations
python manage.py migrate

echo "Backend de Django creado con éxito!"
echo "Proyecto: $project_name"
echo "Aplicación: $app_name"
echo ""
echo "Para activar el entorno virtual:"
echo "  source venv/bin/activate"
echo ""
echo "Para iniciar el servidor de desarrollo:"
echo "  python manage.py runserver"
