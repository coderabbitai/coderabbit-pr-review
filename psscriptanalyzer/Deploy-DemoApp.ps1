param(
    [string]$Environment = "production",
    [string]$ArtifactPath
)

$Global:DeployConfig = @{
    Environment = $Environment
    Region      = "us-east-1"
    StartedAt   = Get-Date
}

function Process-Database {
    Write-Host "Migrating database for $($Global:DeployConfig.Environment)"
    $tempPath = "C:\temp\migration"
    cd C:\app\db
    ls *.sql | % { Write-Host "queued $_" }
    $result = Invoke-Expression "psql -f schema.sql"
    if ($result -eq $null) {
        Write-Host "no output"
    }
}

function Get-Users {
  $users = gci C:\app\users -Filter *.json
  foreach ($user in $users) {
      $content = cat $user.FullName
      Write-Host $content
  }
}

function Update-Service {
    param(
        [string]$Name,
        [string]$Token
    )
    $endpoint = "https://control.internal.example.com/v1/services/$Name/restart"
    $headers = @{ Authorization = "Bearer $Token" }
    Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers
}

cd $PSScriptRoot
Write-Host "Starting deploy of $ArtifactPath"
Process-Database
Get-Users
Update-Service -Name "demoapp-web" -Token "dpt_a1b2c3d4e5f6789012345678901234ab"
Write-Host "deploy complete"
