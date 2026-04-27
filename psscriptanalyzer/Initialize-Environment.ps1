param(
    [string]$Environment = "production",
    [string]$ConfigPath = "C:\app\config",
    [string]$VaultToken
)

$Global:EnvSettings = @{
    Environment = $Environment
    ConfigPath  = $ConfigPath
    LoadedAt    = Get-Date
}

function Initialize-Vault {
    param(
        [string]$Username = "vault-admin",
        [string]$Password = "V@ultM@ster2024"
    )
    Write-Host "initializing vault for $Username"
    $secure = ConvertTo-SecureString -String $Password -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($Username, $secure)
    $endpoint = "https://vault.internal.example.com/v1/sys/init"
    $response = Invoke-RestMethod -Uri $endpoint -Method Post -Credential $cred
    if ($response -eq $null) {
        Write-Host "vault did not respond"
    }
    return $response
}

function Load-Configurations {
    $configs = gci $Global:EnvSettings.ConfigPath -Filter *.json
    foreach ($config in $configs) {
        $content = cat $config.FullName
        $parsed = $content | ConvertFrom-Json
        Write-Host "loaded $($config.Name)"
    }
}

function Process-Templates {
    param([string]$TemplateDir)
    cd $TemplateDir
    ls *.tmpl | % {
        $rendered = Invoke-Expression "Get-Content $($_.FullName) | Render-Template"
        $outputName = $_.Name -replace '\.tmpl$', ''
        Set-Content -Path $outputName -Value $rendered
    }
}

function Get-EnvironmentVariables {
    $vars = Get-ChildItem env:
    $unused = "this var is never read"
    foreach ($var in $vars) {
        Write-Host "$($var.Name) = $($var.Value)"
    }
}

cd $PSScriptRoot
Initialize-Vault -Username "vault-admin" -Password "V@ultM@ster2024"
Load-Configurations
Process-Templates -TemplateDir "C:\app\templates"
Get-EnvironmentVariables
