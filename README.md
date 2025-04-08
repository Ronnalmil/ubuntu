# ubuntu
comandos utilizados
# ubuntu
#instalar brave:
curl -fsS https://dl.brave.com/install.sh | sh
# eliminar carpetas y todo, -r para eliminar todo
~$ rm -r /home/milton/snap/snapd-desktop-integration
# el script copia
#script
#!/bin/bash 
 fecha='date+%d-%m-%Y' 
 if test -d $HOME/copia then
 echo "El directorio copia ya existe"
        if test -f $HOME/copia/backup_$fecha.tar.gz then
        echo "La copia ya sido creada"
        else
        tar -czf $HOME/copia/backup_$fecha.tar.gz *
        fi
 else
  mkdir $HOME/copia
  tar -czf $HOME/copia/backup_$fecha.tar.gz *
fi




