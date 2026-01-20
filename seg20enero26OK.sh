#probar el de usuario en ubuntu si puede iniciar sesion .
#!/bin/bash

LOG_FILE="/var/log/seguridad_usuarios.log"
USUARIO=$1

if [ $# -ne 1 ]; then
    echo "Debe ingresar el nombre de un usuario como parámetro"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "Debes ser usuarios root para ejecutar este script"
    exit 1
fi

registrar_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $USUARIO - $1" >> "$LOG_FILE"
}
#ver otro método.. 

if id "$USUARIO" &>/dev/null; then
    echo "El usuario ya existe"
else
    useradd "$USUARIO"
    registrar_log "Creación de usuario"
    #otro método.
fi

echo "--- ESTADO INICIAL ---"
chage -l "$USUARIO"
registrar_log "Consulta del estado inicial de la cuenta"
#otro metod..

opcion=-1
## podrías dejar vacio
while [ "$opcion" -ne 0 ]; do
    echo -e "\n1) Establecer contraseña\n2) Forzar cambio próximo inicio\n3) Fecha caducidad\n4) Políticas contraseña\n5) Bloquear\n6) Desbloquear\n0) Finalizar"
    read -p "Opción: " opcion

    case $opcion in
        1) passwd "$USUARIO" && registrar_log "Cambio de contraseña" ;;
        2) chage -d 0 "$USUARIO" && registrar_log "Forzado de cambio de contraseña" ;;
        3) read -p "Fecha (AAAA-MM-DD): " f && chage -E "$f" "$USUARIO" && registrar_log "Caducidad: $f" ;;
        4) 
           read -p "Mín: " mi && read -p "Máx: " ma && read -p "Aviso: " av
           chage -m "$mi" -M "$ma" -W "$av" "$USUARIO"
           registrar_log "Políticas: min=$mi, max=$ma, aviso=$av" ;;
        5) passwd -l "$USUARIO" && registrar_log "Cuenta bloqueada" ;;
        6) passwd -u "$USUARIO" && registrar_log "Cuenta desbloqueada" ;;
        0) registrar_log "Finalización de configuración" ;;
    esac
done

echo "--- ESTADO FINAL ---"
chage -l "$USUARIO"
registrar_log "Consulta final del estado"
registrar_log "Cierre de la sesión de configuración"


####################################################################################################################################################
COMENTADO   COMENTADO COMENTADO
######################################################################################################################################################

2026-01-20 00:21:01 - rony - Creación de usuario
2026-01-20 00:21:01 - rony - Consulta del estado inicial de la cuenta
2026-01-20 00:21:42 - rony - Cambio de contraseña
2026-01-20 00:22:08 - rony - Forzado de cambio de contraseña
2026-01-20 00:22:35 - rony - Caducidad: 2026-01-21
2026-01-20 00:23:00 - rony - Políticas: min=10, max=20, aviso=hola
2026-01-20 00:23:37 - rony - Políticas: min=10, max=20, aviso=2
2026-01-20 00:23:51 - rony - Cuenta bloqueada
2026-01-20 00:24:03 - rony - Cuenta desbloqueada
2026-01-20 00:24:16 - rony - Cuenta desbloqueada
2026-01-20 00:24:26 - rony - Finalización de configuración
2026-01-20 00:24:26 - rony - Consulta final del estado
2026-01-20 00:24:26 - rony - Cierre de la sesión de configuración
2026-01-20 00:26:01 - rony - Consulta del estado inicial de la cuenta
2026-01-20 00:26:21 - rony - Cambio de contraseña




#######################################################################################################################################################
DEL GEMINI ok ok

Explicación línea a línea
Bash
#!/bin/bash
Explicación: Es el Shebang. Indica al sistema que este archivo debe ejecutarse usando el intérprete de Bash.

Bash
LOG_FILE="/var/log/seguridad_usuarios.log"
USUARIO=$1
Explicación: Definimos variables. LOG_FILE es la ruta del archivo donde guardaremos las acciones. USUARIO=$1 toma el primer argumento que escribas después del nombre del script (ej: ./seg.sh lara).

Bash
if [ $# -ne 1 ]; then
    echo "Error: Se requiere exactamente un parámetro."
    exit 1
fi
Explicación: Control de parámetros. $# cuenta cuántos argumentos pasaste. Si no es igual a 1 (-ne 1), muestra un error y cierra el script (exit 1).

Bash
if [ "$EUID" -ne 0 ]; then
    echo "Error: Debe ejecutarse como root."
    exit 1
fi
Explicación: Control de privilegios. $EUID es el ID del usuario que ejecuta el script. El root siempre es 0. Si no eres root, no puedes gestionar usuarios, así que el script se detiene.

Bash
registrar_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $USUARIO - $1" >> "$LOG_FILE"
}
Explicación: Es una función para no repetir código. Cada vez que la llamamos, escribe la fecha actual, el nombre del usuario y la acción realizada ($1) dentro del archivo de log.

Bash
if id "$USUARIO" &>/dev/null; then
    echo "El usuario ya existe."
else
    useradd "$USUARIO"
    registrar_log "Creación de usuario"
fi
Explicación: Gestión del usuario. El comando id busca al usuario. Si no lo encuentra, lo crea con useradd y anota la creación en el log.

Bash
echo "--- ESTADO INICIAL ---"
chage -l "$USUARIO"
registrar_log "Consulta del estado inicial de la cuenta"
Explicación: Requisito de visualización. Muestra por pantalla la configuración actual de seguridad de ese usuario (cuándo caduca su clave, etc.) y lo anota en el log.

Bash
opcion=-1
while [ "$opcion" -ne 0 ]; do
Explicación: Bucle interactivo. Creamos una variable opcion y decimos: "mientras la opción no sea 0, sigue mostrando el menú".

Bash
    echo -e "\n1) Establecer contraseña\n2) Forzar cambio próximo inicio..."
    read -p "Opción: " opcion
Explicación: echo imprime el menú y read pausa el script para que tú escribas un número, que se guardará en la variable opcion.

Bash
    case $opcion in
        1) passwd "$USUARIO" && registrar_log "Cambio de contraseña" ;;
        ...
Explicación: El bloque case es como un selector. Si pulsas 1, ejecuta passwd; si pulsas 5, bloquea la cuenta, etc. El símbolo && hace que si el comando funciona bien, se ejecute después la función de log.

Bash
echo "--- ESTADO FINAL ---"
chage -l "$USUARIO"
registrar_log "Consulta final del estado"
registrar_log "Cierre de la sesión de configuración"
Explicación: Una vez sales del bucle (pulsando 0), el script muestra cómo ha quedado la cuenta tras los cambios y hace las últimas anotaciones en el log.

Mini Guía Resumen: ¿Qué hace el programa?
Este programa es una herramienta de auditoría y gestión de seguridad para cuentas de usuario en Linux. Sus funciones principales son:

Validación de entorno: Asegura que solo el administrador (root) pueda usarlo y que se introduzca un nombre de usuario válido.

Aprovisionamiento automático: Si el usuario indicado no existe en el sistema, el script lo crea automáticamente antes de empezar.

Auditoría continua (Logging): Cada movimiento que hace el administrador queda registrado con fecha y hora en /var/log/seguridad_usuarios.log, lo que permite saber quién hizo qué y cuándo.

Gestión de Directivas: Permite, de forma sencilla y visual, cambiar contraseñas, forzar caducidades, establecer políticas de días mínimos/máximos para las claves y bloquear/desbloquear el acceso al sistema.

Verificación de cambios: Compara el estado de la cuenta al principio y al final del proceso para confirmar que las políticas de seguridad se aplicaron correctamente.
