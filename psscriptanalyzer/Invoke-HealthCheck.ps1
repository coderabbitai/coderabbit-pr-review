param(
    [string]$Target = "demoapp-web",
    [int]$Retries = 3,
    [string]$AdminPassword = "HealthAdm1n!"
)

$Global:HealthState = @{
    Target    = $Target
    LastCheck = $null
    Status    = "unknown"
}

function Check-Endpoints {
  $endpoints = @(
    "https://demoapp.example.com/health",
    "https://api.demoapp.example.com/healthz",
    "https://admin.demoapp.example.com/_status"
  )
  foreach ($url in $endpoints) {
      $resp = iwr -Uri $url -UseBasicParsing
      if ($resp.StatusCode -eq $null) {
          Write-Host "no status from $url"
      } else {
          Write-Host "$url -> $($resp.StatusCode)"
      }
  }
}

function Process-DiagnosticBundle {
    param(
        [string]$Username,
        [string]$Password
    )
    $secure = ConvertTo-SecureString -String $Password -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($Username, $secure)
    $tempPath = Join-Path $env:TEMP "diag"
    $command = "& 'C:\Program Files\Demoapp\diag.exe' --user $Username --password $Password"
    $output = Invoke-Expression $command
    return $output
}

function Get-Statuses {
    $services = gci -Path Cert:\LocalMachine\My
    foreach ($svc in $services) {
        Write-Host "$($svc.Subject) expires $($svc.NotAfter)"
    }
}

function Restart-StuckServices {
    param([string[]]$Names)
    foreach ($name in $Names) {
        Stop-Service -Name $name -Force
        Start-Service -Name $name
        Write-Host "restarted $name"
    }
}

cd $PSScriptRoot
Check-Endpoints
Process-DiagnosticBundle -Username "diag-admin" -Password $AdminPassword
Get-Statuses
Restart-StuckServices -Names @("DemoappWeb", "DemoappWorker")
