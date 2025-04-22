#!/bin/bash

# Mostrar título
echo "============================"
echo "  Script de Redirección"
echo "============================"
echo ""

# Pedir URL de redirección
read -p "¿A qué URL querés redirigir? (incluye https://): " redirect_url

# Validar que la URL no esté vacía
if [[ -z "$redirect_url" ]]; then
  echo "❌ No se ingresó una URL. Abortando."
  exit 1
fi

# Ruta del directorio web
WEB_DIR="/www"

# Verificar que el directorio exista
if [[ ! -d "$WEB_DIR" ]]; then
  echo "❌ El directorio $WEB_DIR no existe. Verificá la ruta."
  exit 1
fi

# Eliminar contenido previo
echo "🧹 Limpiando el contenido de $WEB_DIR..."
rm -rf "$WEB_DIR"/*

# Crear index.php con redirección
echo "⚙️  Creando archivo index.php..."
cat <<EOF > "$WEB_DIR/index.php"
<?php
header("Location: $redirect_url", true, 301);
exit;
?>
EOF

# Confirmar éxito
if [[ -f "$WEB_DIR/index.php" ]]; then
  echo "✅ Redirección creada correctamente a: $redirect_url"
  echo "📁 Archivo generado en: $WEB_DIR/index.php"
else
  echo "❌ Ocurrió un error al crear el archivo."
fi
