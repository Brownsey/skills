#requires -Version 5.1
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$manifest = Get-Content -LiteralPath (Join-Path $repositoryRoot 'cli/tools.json') -Raw | ConvertFrom-Json
$missingRequired = @()

foreach ($tool in $manifest.tools) {
    $command = Get-Command -Name $tool.command -CommandType Application, ExternalScript -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($null -ne $command) {
        Write-Host "Available: $($tool.name) ($($command.Source))"
    } else {
        $label = if ($tool.required) { 'Required' } else { 'Optional' }
        Write-Host "$label tool missing: $($tool.name)"
        Write-Host "  $($tool.installation)"
        if ($tool.required) { $missingRequired += $tool.name }
    }
}

if ($missingRequired.Count -gt 0) {
    throw "Missing required tools: $($missingRequired -join ', ')"
}
Write-Host 'Required CLI tools are available. Optional missing tools do not block skill installation.'
