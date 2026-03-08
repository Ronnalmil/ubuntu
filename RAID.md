RAID

RAID CERO
comando : lsblk  muestra mundo

1  instale
mdadm -y ,

2  crea raid 0
sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=0  /dev/sde  /dev/sdf

2 observamos si existe
sudo  cat /proc/mdstat

3  formato al raid
sudo mkfs.ext4  dev/md0

4  asignamos la letra   Y   montamos
sudo mkdir -p  /mnt/raid0
sudo mount /dev/md0  /mnt/raid0

5 observamos existe
df -h

6 busca UUID
sudo blkid /dev/md0

7 añadimos a  etc/fstab
UUID=..    /mnt/raid0   ext4  defaults  0  0

8 df  -h
reboot
ok

RAID 1, los pasos del CERO
RAID 5, los pasos del CERO

Provocar el Fallos de un Disco, Remover, Añadir del raid 5

1 ver el estado, busca  sdl
sudo mdadm --detail   /dev/md5

2 fallo
sudo mdadm  /dev/md5   --fail  /dev/sdl

3 comprobamos con el paso 1,    sudo mdadm --detail   /dev/md5

4 remover el disco
sudo mdadm  /dev/md5   --remove   /dev/sdl

5 añadimos nuevo o mismo disco para el raid5
sudo mdadm /dev/md5  --add  /dev/sdl

6 observamos
sudo mdadm --detail  /dev/md5

ok










PARA ELIMINAR UN RAID 5

sudo mdadm --unmount  /dev/md5
sudo mdadm    --stop  /dev/md126      ok(dev/md5=md126, búscalo, sudo cat proc/mdstat)
sudo mdadm    -delete /dev/md5
sudo mdadm -reconfigure /dev/md5



PARA RECORDAR EL RAID CAMBIA DE NOMBRE CUANDO SE LO REINICIA
ASI QUE PARA SABER SU NOMBRE USA COMANDO,
lsblk,  
PLUS-> APAREZCA EL DISCO RAID EN PANTALLA CREA Y MONTA








 
