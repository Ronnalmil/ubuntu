XRPD  REMOTO  WIN(remoto) -> UBUNTUCLIENTE
1
sudo apt install xrdp

2 PUERTO ABRIR
sudo ufw allow 3389/tcp
sudo ufw reload

3 usuario
sudo adduser xrdp ssl-cert

4 WINDOWS habilitar el remoto
escribir el IP de ubuntucliente

5
ingresar el usuario:  xrdp
contraseña:           123.

6 como dato, si olvidaste la contraseña de xrdp
sudo passwd xrdp,  listo se actualizará

7 COMO DATO
para entrar con el usuario milton
TIENES QUE CERRAR LA SESSION DE MILTON
ahora si se abre con el usuario milton
en la imagen mostrará un ratón

OK

OK
reiniciar
comandos: systemctl restart xrdp


USAR LO DE ARRIBA MEJOR |

más opciones :  
paso 1
sudo apt install xfce4 

paso2
echo xfce4-session > ~/.xsession


REMMINA    UBUNTUCLIENTE -> WINDOWS
1
abre el remmina
2
IP
nombre de usuario
contraseña

listo
OK
