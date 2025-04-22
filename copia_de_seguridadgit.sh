#!/bin/bash
fecha=$(date +%d-%m-%Y)
hora=$(date +%H-%M-%S)  # Añadimos hora para hacerlo aún más único
fecha_backup="${fecha}_backup_${hora}"  # Añadimos la hora al nombre
log_file="$HOME/backup/$fecha.log"
backup_file="$HOME/backup/$fecha_backup.tar.gz"

carpetas_txt="$HOME/configuracion/carpetasbackup.txt"

echo "INICIO $(date +%H:%M:%S)" >> "$log_file"

# directorio
if [ -d "$HOME/backup" ]; then
  echo "DIR_OK" >> "$log_file"
else
  mkdir "$HOME/backup"
  echo "DIR_CREADO" >> "$log_file"
fi
#direcrorio
if [ ! -d "$HOME/backup/snapshots" ]; then
  mkdir "$HOME/backup/snapshots"
  echo "SNAP_CREADO" >> "$log_file"
else
  echo "SNAP_OK" >> "$log_file"
fi
#directorio
if [ -d "$HOME/configuracion" ]; then
  echo "CONF_OK" >> "$log_file"
else
  mkdir "$HOME/configuracion"
  echo "CONF_CREADO" >> "$log_file"
fi

#
echo "Generando lista de carpetas en el directorio actual..." >> "$log_file"
find . -maxdepth 1 -type d -not -path "." > "$carpetas_txt"

if [ -f "$carpetas_txt" ]; then
  echo "Lista de carpetas guardada en $carpetas_txt" >> "$log_file"
else
  echo "ERROR al crear el archivo de carpetas." >> "$log_file"
fi
