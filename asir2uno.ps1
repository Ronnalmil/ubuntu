# Creo el usuario
$usuario = Read-Host "Ingrese nombre de usuario"
$contraseña = Read-Host "Ingrese una contraseña " -AsSecureString

# Crear usuario local
New-LocalUser -Name $usuario -Password $contraseña -Description "Usuario nuevo" -FullName $usuario
Write-Host "Usuario $usuario creado"

# Inicializar datos opcionales
$fullname    = $null
$password    = $null
$descripcion = $null

# Creo hashtable para los datos opcionales
$datos = @{
    fullname    = $fullname
    password    = $password
    descripcion = $descripcion
}

# Preguntar si desea mostrar y actualizar sus datos
$mostrar = Read-Host "¿Desea ingresar o actualizar sus datos? (si/no)"
if ($mostrar.ToLower() -eq "si") {

    foreach ($key in @($datos.Keys)) {
        $nuevo = Read-Host "Ingrese valor para $key (enter para dejar igual)"
        if (-not [string]::IsNullOrWhiteSpace($nuevo)) {
            switch ($key) {
                "password" { $datos[$key] = ConvertTo-SecureString $nuevo -AsPlainText -Force }
                default { $datos[$key] = $nuevo }
            }
        }
    }

    # 6. Aplicar cambios al usuario local
    Set-LocalUser -Name $usuario -FullName $datos.fullname -Description $datos.descripcion
    if ($datos.password) { Set-LocalUser -Name $usuario -Password $datos.password }

    Write-Host "`nDatos actualizados correctamente en el usuario local."
} else {
    Write-Host "No se ingresaron ni actualizaron datos."
}
