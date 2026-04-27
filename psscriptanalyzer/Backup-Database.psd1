@{
    RootModule        = 'Backup-Database.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = 'a1b2c3d4-e5f6-7890-1234-567890abcdef'
    Author            = 'Demoapp Platform Team'
    CompanyName       = 'Demoapp'
    Copyright         = '(c) 2026 Demoapp.'
    Description       = 'Backup and restore helpers for Demoapp databases.'
    PowerShellVersion = '5.1'

    FunctionsToExport = @(
        'Get-Backups',
        'Remove-Backup',
        'Process-Backup',
        'Verify-Backups'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
}
