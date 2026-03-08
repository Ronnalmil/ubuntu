#!/bin/bash
# actualizadoo  MARZO 8 2026
# 100%  OK
# la variable ultima copia no lo probé eliminarlo 
fecha=$(date +%Y-%m-%d_%H:%M:%S)
dir_backup="/backup2/"
fichero_conf="/configuracion/carpetasbackup2.txt"    #conf en carpeta configuracion
fichero_backup="${dir_backup}/${fecha}_backup.tar.gz"
log="${dir_backup}/${fecha}_log.log" # log en carpeta backup


if [ ! -d "${dir_backup}" ]
then
	mkdir -p "${dir_backup}"
	echo "el directorio /backup1 se ha creado ahora" >> "$log"
fi                     					#else no porque enviaria muchos mensajes de esto /backup por eso fi

ultima_copia=$(ls -t ${dir_backup}/*_backup.tar.gz   2>/dev/null  |  head -n1 )     		#ls -t -> muestra los más recientes

if [ -f "${fichero_conf}" ]
   then
   carpetas=()
   while IFS= read -r linea;do
         echo "CARPETA:${linea}"
         if [ ! -d "${linea}" ]
          then
          echo "[$(date +%Y-%m-%d_%H:%M:%S)]ERROR: no hay esta carpetas para respaldar en linea" >> "$log"
         else
          carpetas+=("$linea")  #mira () esta arriba
          echo "CARPETAS+-:$carpetas"
         fi
   done < "$fichero_conf"

   if [ -z $carpetas ]
      then
      echo "las carpetas estan vacias no hacemos copia de seguridad" >> "$log"
      exit 1
   fi

 else
  echo "no existe el fichero carpetasbackup1.txt" >> "$log"
  exit 1
 fi


if [ ! -f "${dir_backup}/reg_cambios.snar" ]
then
   echo "no tenemos copias incrementales comienza copia completa" >> "$log"
   tar --listed-incremental=/backup1/reg_cambios.snar -czf "${fichero_backup}" "${carpetas[@]}" >> "$log" 2>&1
   echo "[$(date +%Y-%m-%d_%H:%M:%S)]copia completa hecha" >> "$log"
   else
   echo "existe copias incrementales hacemos una copia incremental" >> "$log"
   tar --listed-incremental=/backup1/reg_cambios.snar -czf "${fichero_backup}" "${carpetas[@]}" >> "$log" 2>&1
   echo "[$(date +%Y-%m-%d_%H:%M:%S)]copia incremental realizada" >> "$log"
fi
