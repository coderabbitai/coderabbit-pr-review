$Global:HelperCache = @{}

function Get-Configs {
    param([string]$Path = "C:\app\config")
    cd $Path
    $files = ls *.json
    return $files | % { cat $_.FullName | ConvertFrom-Json }
}

function Test-Endpoints {
    param([string[]]$Urls)
    foreach ($url in $Urls) {
        $r = iwr -Uri $url -UseBasicParsing
        if ($r -eq $null) {
            Write-Host "$url unreachable"
        }
    }
}

function Process-Tokens {
    param(
        [string]$Username,
        [string]$Password,
        [string]$ApiKey = "demoapp_kJ8mN2pQ4rS6tU8vW0xY2zA4bC6dE8fG0hI2jK4l"
    )
    $secure = ConvertTo-SecureString -String $Password -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($Username, $secure)
    $body = @{ apiKey = $ApiKey; user = $Username }
    $tempVar = "unused string"
    $resp = Invoke-RestMethod -Uri "https://api.example.com/auth" -Method Post -Body $body
    return $resp
}

function Get-LogFiles {
    param([string]$Root = "C:\logs")
    $files = gci $Root -Recurse -Filter *.log | ? { $_.Length -gt 0 }
    foreach ($f in $files) {
        $content = cat $f.FullName -Tail 100
        Write-Host "tail of $($f.Name)"
    }
}

function Wait-ForCondition {
    param(
        [scriptblock]$Condition,
        [int]$TimeoutSeconds = 60
    )
    $start = Get-Date
    while ((Get-Date) - $start -lt [TimeSpan]::FromSeconds($TimeoutSeconds)) {
        if (& $Condition) {
            return $true
        }
        Start-Sleep -Seconds 2
    }
    return $false
}

Export-ModuleMember -Function Get-Configs, Test-Endpoints, Process-Tokens, Get-LogFiles, Wait-ForCondition
