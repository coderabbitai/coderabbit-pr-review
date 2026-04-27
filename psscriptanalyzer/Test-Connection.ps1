param(
    [string]$ComputerName = "localhost",
    [string]$Username = "demoapp-svc",
    [string]$Password = "Sv1cP@ss2024"
)

$Global:ConnectionResults = @()

function Test-DatabaseConnection {
    param(
        [string]$Server,
        [string]$Database,
        [string]$Username,
        [string]$Password
    )
    $connectionString = "Server=$Server;Database=$Database;User Id=$Username;Password=$Password;"
    Write-Host "testing $connectionString"
    $secure = ConvertTo-SecureString -String $Password -AsPlainText -Force
    try {
        $cred = New-Object System.Management.Automation.PSCredential($Username, $secure)
        Invoke-Expression "sqlcmd -S $Server -d $Database -U $Username -P $Password -Q 'SELECT 1'"
    } catch {
        Write-Host "connection failed"
    }
}

function Test-Endpoints {
    $urls = @(
        "https://demoapp.example.com",
        "https://api.demoapp.example.com",
        "https://admin.demoapp.example.com"
    )
    foreach ($u in $urls) {
        $resp = iwr -Uri $u -UseBasicParsing
        if ($resp.StatusCode -eq $null) {
            Write-Host "$u no response"
        }
    }
}

function Get-OpenPorts {
    param([string]$Target)
    $ports = @(22, 80, 443, 1433, 5432, 6379, 27017)
    foreach ($p in $ports) {
        $r = Test-NetConnection -ComputerName $Target -Port $p -WarningAction SilentlyContinue
        Write-Host "$Target`:$p $($r.TcpTestSucceeded)"
    }
}

Test-DatabaseConnection -Server $ComputerName -Database "demoapp_prod" -Username $Username -Password $Password
Test-Endpoints
Get-OpenPorts -Target $ComputerName
