$nou = Read-Host "Cuantas unidades organizativas desea crear"
$ngrupos = Read-Host "cuantos grupos desea crear en cada unidad organizativa"
$nusuarios = Read-Host "cuantos usuarios desea crear en cada grupo"

$log = "C:\fichero.txt"

"Crea unidades organizativas, grupos, usuarios" | Set-Content $log
if (-not $nou ) {
    write-host "no se ingreso un numero para crear las unidades organizativas"
    break
    }
    elseif (-not $ngrupos) {
        write-host "no se ingreso el numero para crear los grupos"
        break
        }
        elseif (-not $nusuarios) {
            Write-Host "no se ingreso el numero para crear los usuarios"
            break
            }

            else {
             "todos los datos se ingresaron por teclado ¡perfecto!" | Add-Content $log
            }
#hashtable vacia para ingresar los datos
$hashtable = @{
            "claveOU"      = @()
            "clavegrupo"   = @()
            "claveusuario" = @()
}
$claves in $hashtable.keys  #nou
for ($i in 1..$nou){
$clave1 = $hashtable[claveOU][$i]
$Tnombre = "nombre para el usuario de la posicion"
$clave1=$Tnombre
}# for
$hashtable[clavegrupo][$j]
"diga nombre del grupo"


foreach()

    foreach ($clave in @("OU", "grupo", "usuario")) {
    if ($clave -eq "OU") {    
        for ($i=1, $i -le $nou, $i++){
        $ouNombre = Read-Host "Ponga un nombre a la Unidad Organizativa : "
            if (-not $ouNombre) {
                            Write-Host "No se ingresó un nombre a la Unidad Organizativa vuelva a ingresarlo";
                            return
                            }
            New-ADOrganizationalUnit -Name $ouNombre -Path "dc=milton,dc=local" -ProtectedFromAccidentalDeletion $false
            #"Creando la Unidad Organizativa $ouNombre" | Add-Content $log  esto se imprime al final como tabla
            $hashtable["$clave"] += "$ouNombre"
        }
    }
        elseif ($clave -eq "grupo") {
        foreach ($group in $hashtable["OU"]) {
        for ($i=1, $i -le $ngrupos, $i++){
        $grupoNombre = Read-Host "Ponga un nombre al grupo de la Unidad Organizativa $ouNombre "
            if (-not $grupoNombre) {
                            Write-Host "No se ingresó el grupo. Finalizando.";
                            break
                            }
                $grupoRuta = "ou=$ouNombre,dc=milton,dc=local"
                New-ADGroup -Name $grupoNombre -Path $grupoRuta -GroupCategory Security -GroupScope Global
                "Creando el Grupo $grupoNombre en la Unidad Organizativa $ouNombre " | Add-Content $log
                $hashtable["$group"] += "$grupoNombre"
          }
          elseif ($clave -eq "usuario") {
          foreach ($usu in $hashtable["usuario"]) {
            for($i=1, $i -le $nusuarios,$i++){
            $usuarioNombre = Read-Host "Ponga un nombre al usuario que pertenece al grupo $grupoNombre "
                if (-not $usuarioNombre) {
                            Write-Host "No se ingresó el nombre de usuario, fin del script";
                            break
                            }
                $usuarioSamAccountName = Read-Host "Indique el Nombre que se mostrara al iniciar la sesion de $usuarioNombre (puedes usar $usuarioNombre)"
                $usuariocorreo = "$usuarioSamAccountName@$ouNombre.local" #guardamos el correo en la variable $usuariocorreo.

                $usuarioContrasena= Read-Host "Ponga una contraseña al usuario $usuarioNombre "
                $usuarioContrasena = ConvertTo-SecureString "Password123!" -AsPlainText -Force

                New-ADUser -Name "$usuarioNombre" -GivenName $usuarioNombre -SamAccountName $usuarioSamAccountName -UserPrincipalName $usuariocorreo -Path $grupoRuta -AccountPassword $usuarioContrasena -Enabled $true -ChangePasswordAtLogon $true
                "Creando el Usuario $usuarioNombre en la Unidad Organizativa $ouNombre" | Add-Content $log
                $hashtable["$usu"] += "$usuarioNombre"
                 
                # Compruebo si un grupo ya existe,  
                $grupoExistente = Get-ADGroup -Filter { Name -eq $grupoNombre } -ErrorAction SilentlyContinue

                # el usuario es añadido a un grupo correspondiente
               if ($grupoExistente) {
                Add-ADGroupMember -Identity $grupoNombre -Members $usuarioNombre                  
                " Agregado el Usuario $usuarioNombre al grupo $grupoNombre"  | Add-Content $log
                }
                else {
                "El grupo $grupoNombre no existe"  | Add-Content $log
                break
                }  
            } #for usuarios
        } #foreach usuarios
    } #elseif grupos
        }#foreach grupos
    }# FOR
   
}#foreach clave

 Write-Host "estaria hecho"
------------------------------------------------------------------

ultima mrc
$nou = Read-Host "Cuantas unidades organizativas desea crear"
$ngrupos = Read-Host "cuantos grupos desea crear en cada unidad organizativa"
$nusuarios = Read-Host "cuantos usuarios desea crear en cada grupo"

$log = "C:\fichero.txt" 
"Crea unidades organizativas, grupos, usuarios" | Set-Content $log

# Validación inicial
if (-not $nou) { 
    Write-Host "No se ingreso un numero para crear las unidades organizativas"
    return
}
elseif (-not $ngrupos) {
    Write-Host "No se ingreso el numero para crear los grupos"
    return
}
elseif (-not $nusuarios) {
    Write-Host "No se ingreso el numero para crear los usuarios"
    return
}
else {
    "Todos los datos se ingresaron por teclado ¡perfecto!" | Add-Content $log
}

# Hashtable vacía
$hashtable = @{
    "OU"      = @()
    "grupo"   = @()
    "usuario" = @()
}

foreach ($clave in @("OU", "grupo", "usuario")) {
    if ($clave -eq "OU") {
        for ($i=1; $i -le $nou; $i++) { 
            $ouNombre = Read-Host "Ponga un nombre a la Unidad Organizativa : "
            if (-not $ouNombre) { 
                Write-Host "No se ingresó un nombre a la Unidad Organizativa, vuelva a ingresarlo"
                return
            }
            New-ADOrganizationalUnit -Name $ouNombre -Path "dc=milton,dc=local" -ProtectedFromAccidentalDeletion $false
            $hashtable["OU"] += $ouNombre
        }
    }
    elseif ($clave -eq "grupo") {
        foreach ($ouNombre in $hashtable["OU"]) {
            for ($i=1; $i -le $ngrupos; $i++) {
                $grupoNombre = Read-Host "Ponga un nombre al grupo de la Unidad Organizativa $ouNombre "
                if (-not $grupoNombre) { 
                    Write-Host "No se ingresó el grupo. Finalizando."
                    return
                }
                $grupoRuta = "OU=$ouNombre,DC=milton,DC=local"
                New-ADGroup -Name $grupoNombre -Path $grupoRuta -GroupCategory Security -GroupScope Global
                "Creando el Grupo $grupoNombre en la Unidad Organizativa $ouNombre" | Add-Content $log
                $hashtable["grupo"] += $grupoNombre
            }
        }
    }
    elseif ($clave -eq "usuario") {
        foreach ($grupoNombre in $hashtable["grupo"]) {
            for ($i=1; $i -le $nusuarios; $i++) {
                $usuarioNombre = Read-Host "Ponga un nombre al usuario que pertenece al grupo $grupoNombre "
                if (-not $usuarioNombre) { 
                    Write-Host "No se ingresó el nombre de usuario, fin del script"
                    return
                }

                $usuarioSamAccountName = Read-Host "Indique el Nombre que se mostrará al iniciar la sesión de $usuarioNombre (puedes usar $usuarioNombre)"
                $usuariocorreo = "$usuarioSamAccountName@$grupoNombre.local" 

                $usuarioContrasena = ConvertTo-SecureString "Password123!" -AsPlainText -Force

                New-ADUser -Name $usuarioNombre -GivenName $usuarioNombre -SamAccountName $usuarioSamAccountName `
                    -UserPrincipalName $usuariocorreo -Path "OU=$grupoNombre,DC=milton,DC=local" `
                    -AccountPassword $usuarioContrasena -Enabled $true -ChangePasswordAtLogon $true

                "Creando el Usuario $usuarioNombre en el grupo $grupoNombre" | Add-Content $log
                $hashtable["usuario"] += $usuarioNombre

                # Añadir usuario al grupo si existe
                $grupoExistente = Get-ADGroup -Filter { Name -eq $grupoNombre } -ErrorAction SilentlyContinue
                if ($grupoExistente) {
                    Add-ADGroupMember -Identity $grupoNombre -Members $usuarioNombre
                    "Agregado el Usuario $usuarioNombre al grupo $grupoNombre" | Add-Content $log
                } 
                else {
                    "El grupo $grupoNombre no existe" | Add-Content $log
                    return
                }
            }
        }
    }
}

Write-Host "¡Script completado!"

---
New-ADUser : No se encuentra el objeto de directorio
En línea: 73 Carácter: 17
+ ...             New-ADUser -Name $usuarioNombre -GivenName $usuarioNombre ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (CN=usuafrica,OU...milton,DC=local:String) [New-ADUser], ADIdentityN 
   otFoundException
    + FullyQualifiedErrorId : ActiveDirectoryCmdlet:Microsoft.ActiveDirectory.Management.ADIdentityNotFoundExcepti 
   on,Microsoft.ActiveDirectory.Management.Commands.NewADUser
 
Add-ADGroupMember : No se puede encontrar un objeto con la identidad 'usuafrica' en 'DC=milton,DC=local'.
En línea: 83 Carácter: 21
+ ...             Add-ADGroupMember -Identity $grupoNombre -Members $usuari ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (usuafrica:ADPrincipal) [Add-ADGroupMember], ADIdentityNotFoundExcep 
   tion
    + FullyQualifiedErrorId : SetADGroupMember.ValidateMembersParameter,Microsoft.ActiveDirectory.Management.Comma 
   nds.AddADGroupMember



