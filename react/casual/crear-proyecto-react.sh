#!/bin/bash

# Función para mostrar mensajes en color
function echo_info {
    echo -e "\033[1;34m$1\033[0m"
}

function echo_success {
    echo -e "\033[1;32m$1\033[0m"
}

function echo_error {
    echo -e "\033[1;31m$1\033[0m"
}

# Verificar si Node.js está instalado
if ! command -v node &> /dev/null
then
    echo_error "Node.js no está instalado. Por favor, instálalo desde https://nodejs.org/ y vuelve a intentarlo."
    exit 1
fi

# Verificar si npm está instalado
if ! command -v npm &> /dev/null
then
    echo_error "npm no está instalado. Asegúrate de tener npm instalado junto con Node.js."
    exit 1
fi

echo_info "Bienvenido al generador de proyectos React con Vite."

# Preguntar por el nombre del proyecto
read -p "Ingrese el nombre del proyecto: " project_name

# Preguntar por el uso de TypeScript o JavaScript
echo "Selecciona el tipo de proyecto:"
echo "1) JavaScript"
echo "2) TypeScript"
read -p "Ingresa 1 o 2: " project_type

if [[ "$project_type" == "1" ]]; then
    use_typescript=false
    echo_info "Has seleccionado JavaScript."
elif [[ "$project_type" == "2" ]]; then
    use_typescript=true
    echo_info "Has seleccionado TypeScript."
else
    echo_error "Selección inválida. Saliendo."
    exit 1
fi

# Crear el proyecto usando Vite
if [ "$use_typescript" = true ]; then
    echo_info "Creando el proyecto React con TypeScript usando Vite..."
    npm create vite@latest "$project_name" -- --template react-ts
else
    echo_info "Creando el proyecto React con JavaScript usando Vite..."
    npm create vite@latest "$project_name" -- --template react
fi

if [ $? -ne 0 ]; then
    echo_error "Error al crear el proyecto con Vite."
    exit 1
fi

cd "$project_name" || { echo_error "No se pudo acceder al directorio $project_name"; exit 1; }

# Instalar dependencias
echo_info "Instalando dependencias..."
npm install

# Instalar Tailwind CSS
echo_info "Instalando Tailwind CSS..."

# Instalar dependencias de Tailwind
npm install -D tailwindcss postcss autoprefixer

# Inicializar Tailwind
npx tailwindcss init -p

# Configurar Tailwind en los archivos de configuración
tailwind_config="tailwind.config.js"
src_index_file="src/main.jsx"
if [ "$use_typescript" = true ]; then
    src_index_file="src/main.tsx"
fi

# Configurar el contenido de Tailwind
cat > "$tailwind_config" <<EOL
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

# Añadir las directivas de Tailwind a CSS
css_file="src/index.css"
cat > "$css_file" <<EOL
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Reemplazar el archivo de entrada para incluir Tailwind
cat > "$src_index_file" <<EOL
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'
import { BrowserRouter } from 'react-router-dom'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </React.StrictMode>,
)
EOL

# Instalar React Router
echo_info "Instalando React Router..."
npm install react-router-dom

if [ $? -ne 0 ]; then
    echo_error "Error al instalar React Router."
    exit 1
fi

# Configurar App.jsx o App.tsx con React Router y diseño divertido
if [ "$use_typescript" = true ]; then
    app_file="src/App.tsx"
else
    app_file="src/App.jsx"
fi

cat > "$app_file" <<EOL
import React from 'react'
import { Routes, Route, Link } from 'react-router-dom'

function Home() {
  return (
    <div className="bg-gradient-to-r from-purple-400 via-pink-500 to-red-500 min-h-screen flex items-center justify-center">
      <div className="bg-white p-8 rounded-lg shadow-lg text-center">
        <h1 className="text-4xl font-bold mb-4 text-purple-600">¡Hola! Soy Aron Justo</h1>
        <p className="text-xl mb-6 text-gray-700">Desarrollador y YouTuber</p>
        <a href="https://youtube.com" target="_blank" rel="noopener noreferrer" className="bg-red-500 text-white px-6 py-2 rounded-full hover:bg-red-600 transition duration-300">
          Visita mi canal de YouTube
        </a>
      </div>
    </div>
  )
}

function About() {
  return (
    <div className="bg-gradient-to-r from-green-400 to-blue-500 min-h-screen flex items-center justify-center">
      <div className="bg-white p-8 rounded-lg shadow-lg max-w-2xl">
        <h2 className="text-3xl font-bold mb-4 text-green-600">Acerca de mí</h2>
        <p className="text-lg mb-4 text-gray-700">
          Soy un apasionado desarrollador que disfruta compartiendo conocimientos a través de mi canal de YouTube.
          Mi objetivo es hacer que el aprendizaje de la programación sea divertido y accesible para todos.
        </p>
        <p className="text-lg text-gray-700">
          ¡Únete a mi comunidad y comencemos este emocionante viaje de codificación juntos!
        </p>
      </div>
    </div>
  )
}

function App() {
  return (
    <div className="font-sans">
      <nav className="bg-gray-800 text-white p-4">
        <ul className="flex space-x-4 justify-center">
          <li><Link to="/" className="hover:text-purple-300 transition duration-300">Inicio</Link></li>
          <li><Link to="/about" className="hover:text-green-300 transition duration-300">Acerca de</Link></li>
        </ul>
      </nav>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </div>
  )
}

export default App
EOL

# Limpiar la consola
clear

echo_success "¡Proyecto React con Vite '$project_name' creado exitosamente!"
echo_info "Para comenzar:"
echo "  cd $project_name"
echo "  npm run dev"
