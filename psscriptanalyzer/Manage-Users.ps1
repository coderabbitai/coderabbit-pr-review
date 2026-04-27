function New-LocalAdmin {
    param(
        [string]$Username,
        [string]$Password
    )
    Write-Host "creating user $Username"
    $secure = ConvertTo-SecureString -String $Password -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($Username, $secure)
    New-LocalUser -Name $Username -Password $secure -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $Username
    return $cred
}

function Connect-AdminSession {
    param(
        [string]$ComputerName,
        [string]$AdminPassword = "AdminP@ss2024"
    )
    $secure = ConvertTo-SecureString -String $AdminPassword -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential("Administrator", $secure)
    Enter-PSSession -ComputerName $ComputerName -Credential $cred
}

function Reset-UserPassword {
    param([string]$Username)
    $newPassword = "Temp_P@ss_$(Get-Random)"
    $secure = ConvertTo-SecureString -String $newPassword -AsPlainText -Force
    Set-LocalUser -Name $Username -Password $secure
    Write-Host "password reset for $Username to $newPassword"
}

$adminUsername = "demoapp-admin"
$adminPassword = "Adm1nP@ssword2024"
New-LocalAdmin -Username $adminUsername -Password $adminPassword

$serviceAccount = "demoapp-svc"
Connect-AdminSession -ComputerName "BUILD-AGENT-01"
Reset-UserPassword -Username $serviceAccount
