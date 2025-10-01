$OU = "OU=TecnoGlobalSL,DC=cosmos,DC=local"
$log= "C:\scriptusuarios.txt"

$GruposUsuarios = @{
    "ventass"  = @("ana.ventass", "juan.ventass")
    "soportes" = @("maria.soportes", "pedro.soportes")
}

" Creamos usuarios, grupos y OU " | Set-Content $log

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'TecnoGlobalSL'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "TecnoGlobalSL" -Path "DC=cosmos,DC=local"
    "La (OU)Unidad organizativa  TecnoGlobalSL esta creada" | Add-Content $log
}

foreach ($grupo in $GruposUsuarios.Keys) {
    if (-not (Get-ADGroup -Filter "Name -eq '$grupo'" -SearchBase $OU -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $grupo -GroupScope Global -GroupCategory Security -Path $OU
        " esta creado un nuevo grupo: $grupo  " | Add-Content $log
    }

    foreach ($user in $GruposUsuarios[$grupo]) {
        if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'" -SearchBase $OU -ErrorAction SilentlyContinue)) {
            New-ADUser -Name $user 
                       -SamAccountName $user 
                       -AccountPassword (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force) 
                       -Enabled $true 
                       -ChangePasswordAtLogon $true 
                       -Path $OU
            Add-ADGroupMember -Identity $grupo -Members $user
            " esta creado el nuevo usuario $user y se añadido al grupo $grupo" | Add-Content $log
        }
    }
}
