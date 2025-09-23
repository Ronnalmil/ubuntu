# 1. Crear usuario local inicial
$usuario    = Read-Host "Ingrese nombre de usuario"
$contraseña = Read-Host "Ingrese una contraseña " -AsSecureString

New-LocalUser -Name $usuario -Password $contraseña -Description "Usuario nuevo" -FullName $usuario
Write-Host "Usuario $usuario creado"

# 2. Inicializar datos opcionales en hashtable anidado
$datos = @{
    parametro1 = @{ nombre = "fullname";    valor = $null }
    parametro2 = @{ nombre = "contraseña"; valor = $null }
    parametro3 = @{ nombre = "descripcion"; valor = $null }
}

# 3. Preguntar si quiere actualizar datos
$mostrar = Read-Host "¿Desea ingresar o actualizar sus datos? (si/no)"
if ($mostrar.ToLower() -eq "si") {

    foreach ($param in $datos.Keys) {
        $info = $datos[$param]

        # Preguntar valor nuevo
        $nuevo = Read-Host "Ingrese valor para $($info.nombre) (enter para dejar igual)"

        # Validar si se ingresó algo
        if (-not [string]::IsNullOrWhiteSpace($nuevo)) {
            if ($info.nombre -eq "contraseña") {
                $info.valor = ConvertTo-SecureString $nuevo -AsPlainText -Force
            } else {
                $info.valor = $nuevo
            }
        }
    }

    # 4. Aplicar cambios al usuario local
    Set-LocalUser -Name $usuario -FullName $datos.parametro1.valor -Description $datos.parametro3.valor
    if ($datos.parametro2.valor) {
        Set-LocalUser -Name $usuario -Password $datos.parametro2.valor
    }

    Write-Host "`nDatos actualizados correctamente en el usuario local."
} else {
    Write-Host "No se ingresaron ni actualizaron datos."
}
