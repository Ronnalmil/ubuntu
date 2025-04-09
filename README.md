# ubuntu
comandos utilizados
# ubuntu
#instalar brave:
curl -fsS https://dl.brave.com/install.sh | sh
# eliminar carpetas y todo, -r para eliminar todo
~$ rm -r /home/milton/snap/snapd-desktop-integration
# dar PERMISOS A un fichero o .sh
#recuerda read-write-exe todos 7          primero usuario
          read-write-exe todos 7          segundo grupos
          read-write-exe solo lectura4     tercero otros 
resultado: rwx-rwx-r--          
~$ sudo chmod 774 copiaseguridad.sh

# el script copia
#!/bin/bash 
 fecha=$(date +%d-%m-%Y) 
 if test -d $HOME/copia
 then
 echo "El directorio copia ya existe"
        if test -f $HOME/copia/backup_$fecha.tar.gz
        then
        echo "La copia ya sido creada"
        else
        tar -czf $HOME/copia/backup_$fecha.tar.gz *
        fi
 else
  mkdir $HOME/copia
  tar -czf $HOME/copia/backup_$fecha.tar.gz *
fi

#OTRA ACTIVIDAD
#LYNIS
AUDITORIA-ARCHIVO(ruta absoluta)- Busca cron
examen@examen-VirtualBox:~$ lynis audit system > /home/examen/prueba6.txt | grep cron






