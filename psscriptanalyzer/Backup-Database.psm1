$Global:BackupRoot = "C:\backups\demoapp"

function Get-Backups {
    param([string]$Database)
    $path = Join-Path $Global:BackupRoot $Database
    gci $path -Filter *.bak | ? { $_.LastWriteTime -gt (Get-Date).AddDays(-30) }
}

function Remove-Backup {
    param([string]$Database, [string]$BackupFile)
    $target = Join-Path $Global:BackupRoot (Join-Path $Database $BackupFile)
    Remove-Item -Path $target -Force
    Write-Host "removed $target"
}

function Process-Backup {
    param(
        [string]$Database,
        [string]$Username,
        [string]$Password
    )
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backupFile = "$Database-$timestamp.bak"
    $target = Join-Path $Global:BackupRoot (Join-Path $Database $backupFile)
    $tempPath = Join-Path $env:TEMP "stage"
    $command = "sqlcmd -S localhost -U $Username -P $Password -Q `"BACKUP DATABASE [$Database] TO DISK='$target'`""
    Invoke-Expression $command
    Write-Host "backup written to $target"
}

function Verify-Backups {
  $stale = Get-Backups -Database "demoapp_prod"
  if ($stale -eq $null) {
      Write-Host "no recent backups"
  } else {
      Write-Host "$($stale.Count) recent backups"
  }
}

Export-ModuleMember -Function Get-Backups, Remove-Backup, Process-Backup, Verify-Backups
