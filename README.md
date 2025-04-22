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


#OTRA ACTIVIDAD 09/04/2025
#LYNIS
AUDITORIA-ARCHIVO(ruta absoluta)- Busca cron
examen@examen-VirtualBox:~$ lynis audit system > /home/examen/prueba6.txt | grep cron
# 
-n enumera
-i ignora
-v no muestra los NO 

examen@examen-VirtualBox:~$ sudo cat prueba6.txt | grep -n -i check | grep -e FOUND -e OK -e ENCONTRADO  | grep -v NO

#OTRA MANERA
-m 5 muestra los 5 primeras filas
-C muestra las columnas
-i ignora
examen@examen-VirtualBox:~$ cat /home/examen/prueba6.txt |grep -m 5 -C 2 -i sugerencia


#OTRA MANERA
cut muestra lo ultimo  y luego lo primero 
grep muestra ipv4

examen@examen-VirtualBox:~$ cat /home/examen/prueba6.txt |grep ipv4|cut -d " " -f 2,6


#mostrar los números a la izquierda 
Paso para mostrar los números de línea en Nano:
presiona la siguiente combinación de teclas:
Alt + Shift + 3
Esto activará o desactivará la visualización de los números de línea en el margen izquierdo.

En algunos teclados o configuraciones, puede ser solo Alt + 3.


Si quieres que Nano siempre muestre los números de línea por defecto:

Abre o crea el archivo de configuración:

Copiar código
nano ~/.nanorc
Agrega esta línea:

Copiar código
set linenumbers
Guarda y sal. Ahora cada vez que abras Nano, verás los números de línea automáticamente.




