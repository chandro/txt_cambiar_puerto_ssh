#!/bin/bash

# Definir el nuevo puerto SSH
nuevo_puerto=22222

# Verificar si el archivo de configuración de SSH existe
if [ ! -f /etc/ssh/sshd_config ]; then
    echo "El archivo /etc/ssh/sshd_config no existe."
    exit 1
fi

# Verificar si el puerto SSH ya está configurado en el nuevo puerto
if grep -q "^Port $nuevo_puerto$" /etc/ssh/sshd_config; then
    echo "El puerto SSH ya está configurado en $nuevo_puerto."
    exit 0
fi

# Cambiar el puerto SSH en el archivo de configuración
sed -i "s/^#*Port .*/Port $nuevo_puerto/" /etc/ssh/sshd_config

# Reiniciar el servicio SSH
echo "Reiniciando el servicio SSH..."
if systemctl restart sshd; then
    echo "El puerto SSH se ha cambiado a $nuevo_puerto y el servicio SSH se ha reiniciado con éxito."
else
    echo "Error al reiniciar el servicio SSH. Por favor, reinicie manualmente."
fi

exit 0
