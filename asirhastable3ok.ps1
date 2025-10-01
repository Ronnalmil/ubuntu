$OU = "OU=TecnoGlobalSL,DC=cosmos,DC=local"
$log = "C:\scriptusuarios.txt"

$GruposUsuarios = @{
    "ventass"  = @("ana.ventass", "juan.ventass")
    "soportes" = @("maria.soportes", "pedro.soportes")
}

"Creación de usuarios, grupos y ou" | Set-Content $log

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'TecnoGlobalSL'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "TecnoGlobalSL" -Path "DC=cosmos,DC=local"
    "La unidad organizativa ha sido creada." | Add-Content $log
}


foreach ($grupo in $GruposUsuarios.Keys) {
    if (-not (Get-ADGroup -Filter "Name -eq '$grupo'" -SearchBase $OU -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $grupo -GroupScope Global -GroupCategory Security -Path $OU
        "Se ha creado el grupo: $grupo" | Add-Content $log
    }

    foreach ($usuario in $GruposUsuarios[$grupo]) {
        if (-not (Get-ADUser -Filter "SamAccountName -eq '$usuario'" -SearchBase $OU -ErrorAction SilentlyContinue)) {
            New-ADUser -Name $usuario `
                       -SamAccountName $usuario `
                       -AccountPassword (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force) `
                       -Enabled $true `
                       -ChangePasswordAtLogon $true `
                       -Path $OU
            "Se ha creado el usuario: $usuario." | Add-Content $log
        }
        Add-ADGroupMember -Identity $grupo -Members $usuario
        "El usuario $usuario ha sido añadido al grupo $grupo." | Add-Content $log
    }
}
