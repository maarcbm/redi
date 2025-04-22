#!/bin/bash

# Mostrar título
echo "============================"
echo "  Script de Redirección"
echo "============================"
echo ""

# Verificar si existe el directorio ./www
if [[ ! -d "./www" ]]; then
  echo "❌ No se encontró la carpeta 'www' en el directorio actual: $(pwd)"
  exit 1
fi

# Entrar a la carpeta www
cd ./www || exit

# Pedir URL de redirección
read -p "¿A qué URL quieres redirigir? (incluye https://): " redirect_url

# Validar que no esté vacía
if [[ -z "$redirect_url" ]]; then
  echo "❌ No se ingresó una URL. Saliendo."
  exit 1
fi

# Eliminar todo dentro de www
echo "🧹 Eliminando contenido en $(pwd)..."
rm -rf ./*

# Crear el archivo index.php
echo "⚙️  Creando archivo index.php con redirección..."
cat <<EOF > index.php
<?php
header("Location: $redirect_url", true, 301);
exit;
?>
EOF

# Verificar éxito
if [[ -f "index.php" ]]; then
  echo "✅ Redirección creada correctamente a: $redirect_url"
  echo "📁 Archivo generado en: $(pwd)/index.php"
else
  echo "❌ Ocurrió un error al crear el archivo."
fi
