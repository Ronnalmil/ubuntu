#!/bin/bash
cond="si"
par=$1
while [[ $cond = "si" ]]
do
	read -p "Cuantos usuarios quieres dar de alta" num_usu
	groupadd $1
	groupadd $1 -n GEX_$1
	for ((i=1;i<=$num_usu;++i))
	do
	    read -p "escriba el nombre del usuario" nom
	    adduser $nom
	    usermod $nom -l UEX_$nom -G GEX_$1
	done
mkdir /home/{(examenes,corregidos}
cd /home/
chgrp GEX_$1 examenes | chmod
