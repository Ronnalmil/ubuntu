#!/bin/bash
#actualizado.... 
#Fecha actual
fecha=$(date +%Y-%m-%d)
dir_backup="/backup"
fichero_conf="/configuracion/carpetasBackup.txt"
fichero_backup="${dir_backup}/${fecha}_Backup.tar.gz"
log="${dir_backup}/${fecha}_log.log"
#Creamos el directorio /backup si no existe
if [ ! -d "$dir_backup" ]
then
sudo mkdir -p "$dir_backup"
echo "[$(date +%Y-%m-%d_%H:%M)] Directorio /backup creado. " >> "$log"
fi
#Comprobamos si existe un archivo .tar anterior
ultima_copia=$(ls -t ${dir_backup}*_Backup.tar.gz 2>/dev/null | head -n1)

#Leemos las carpetas desde el archivo de configuracion
#Primero comprobamos que existe
if [ -f "$fichero_conf" ]
then
carpetas=()
while IFS= read -r linea; do
echo "CARPETA:$linea"
if [ ! -d "$linea" ]
then
echo "[$(date +%Y-%m-%d_%H:%M)] ERROR: La carpeta indicada en el fichero de configuración $linea no existe." >> "$log"
else
carpetas+=("$linea")
echo "CARPETAS:$carpetas"
fi
done < "$fichero_conf"
if [ -z "$carpetas" ]
then
echo "[$(date +%Y-%m-%d_%H:%M)] ERROR: Las carpetas indicadas son erroneas.No se realizara ninguna copia de seguridad." >> "$log"
exit 1
fi
else
echo "[$(date +%Y-%m-%d_%H:%M)] ERROR: El archivo de configuración no existe." >> "$log"
exit 1
fi

#Ya tenemos todos los datos preparados yt procedemos a realizar las copias

if [ ! -f "${dir_backup}/reg_cambios.snar" ]
then
echo "[$(date +%Y-%m-%d_%H:%M)] No existen copias anteriores comienza la copia completa." >> "$log"
tar --listed-incremental=/backup/reg_cambios.snar -czf "$fichero_backup" "${carpetas[@]}" >> "$log" 2>&1
echo "[$(date +%Y-%m-%d_%H:%M)] Copia completa realizada." >> "$log"
else
echo "[$(date +%Y-%m-%d_%H:%M)] Existen copias anteriores realizadas. Comienza la copia incremental." >> "$log"
tar --listed-incremental=/backup/reg_cambios.snar -czf "$fichero_backup" "${carpetas[@]}" >> "$log" 2>&1
echo "[$(date +%Y-%m-%d_%H:%M)] Copia incremental realizada." >> "$log"
fi
