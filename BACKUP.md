BACKUP  COPIAS DE SEGURIRDAD 
1
script
2
comprimir 
tar -czf  backup.tar.gz

3  descomprimir        (en donde estés importa)
tar  -xvzf  backupmil.tar.gz 

4 LA UBICACION DONDE ESTES SE EJECUTA,
PERO PODEMOS INDICARLE LA RUTA
tar -xvzf backupmil.tar.gz   -C    /home/milton/GAME

5 como dato
se debe crear el fichero /configuracion/carpetasbackup.txt,
dentro de este fichero se indicará las carpetas,
que se van a guardar en el backup, por ejemplo,
/home/milton/Música
/home/milton/nueva

6 EJECUTAR
ejecutar con sudo,
sudo copiasainhoa.sh,
así no saldrá permiso denegado,
ni tendrás que poner sudo en el .sh

7 ver el backup sin DESCOMPRIMIR
sudo -tvf /backup2/2026-03-08_backupmil.tar.gz

8
ok

