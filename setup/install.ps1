#requires -Version 5.1
[CmdletBinding()]
param(
    [string]$SkillsDirectory = (Join-Path $env:USERPROFILE '.agents/skills'),
    [string]$CodexDirectory = $(if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE '.codex' }),
    [switch]$IncludeGlobalInstructions
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT) {
    throw 'This installer uses Windows directory junctions. Run it on Windows.'
}

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$sourceDirectory = Join-Path $repositoryRoot 'skills'
$SkillsDirectory = [IO.Path]::GetFullPath($SkillsDirectory)
$CodexDirectory = [IO.Path]::GetFullPath($CodexDirectory)
$sourceSkills = @(Get-ChildItem -LiteralPath $sourceDirectory -Directory | Where-Object {
    Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf
})

# Preflight every destination before creating or changing anything.
foreach ($sourceSkill in $sourceSkills) {
    $destination = Join-Path $SkillsDirectory $sourceSkill.Name
    $existing = Get-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue
    if ($null -ne $existing) {
        $matches = $false
        if ($existing.LinkType -in @('Junction', 'SymbolicLink')) {
            $targets = @($existing.Target)
            if ($targets.Count -eq 1) {
                $targetPath = [string]$targets[0]
                if (-not [IO.Path]::IsPathRooted($targetPath)) {
                    $targetPath = Join-Path $SkillsDirectory $targetPath
                }
                $matches = [IO.Path]::GetFullPath($targetPath).TrimEnd('\', '/') -ieq $sourceSkill.FullName.TrimEnd('\', '/')
            }
        }
        if (-not $matches) {
            throw "Skill destination already exists and points elsewhere: $destination. Nothing will be replaced."
        }
    }
}

$instructionsPath = Join-Path $CodexDirectory 'AGENTS.md'
$newInstructions = $null
$oldInstructions = ''
$utf8 = New-Object System.Text.UTF8Encoding($false)

if ($IncludeGlobalInstructions) {
    $beginMarker = '<!-- BEGIN Brownsey/skills shared instructions -->'
    $endMarker = '<!-- END Brownsey/skills shared instructions -->'
    $sharedInstructions = [IO.File]::ReadAllText((Join-Path $repositoryRoot 'global/AGENTS.md')).Trim()
    $managedBlock = $beginMarker + "`n" + $sharedInstructions + "`n" + $endMarker
    if (Test-Path -LiteralPath $instructionsPath) {
        $instructionItem = Get-Item -LiteralPath $instructionsPath -Force
        if ($instructionItem.PSIsContainer -or ($instructionItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            throw "Personal instructions must be a regular file: $instructionsPath. Nothing will be replaced."
        }
        $oldInstructions = [IO.File]::ReadAllText($instructionsPath)
    }
    $beginCount = [regex]::Matches($oldInstructions, [regex]::Escape($beginMarker)).Count
    $endCount = [regex]::Matches($oldInstructions, [regex]::Escape($endMarker)).Count
    if ($beginCount -eq 0 -and $endCount -eq 0) {
        $separator = if ($oldInstructions.Length -eq 0) { '' } elseif ($oldInstructions.EndsWith("`n`n")) { '' } else { "`n`n" }
        $newInstructions = $oldInstructions + $separator + $managedBlock + "`n"
    } elseif ($beginCount -eq 1 -and $endCount -eq 1) {
        $startIndex = $oldInstructions.IndexOf($beginMarker, [StringComparison]::Ordinal)
        $endIndex = $oldInstructions.IndexOf($endMarker, [StringComparison]::Ordinal)
        if ($endIndex -lt $startIndex) { throw 'Shared instruction markers are out of order. Repair them before installing.' }
        $afterIndex = $endIndex + $endMarker.Length
        $newInstructions = $oldInstructions.Substring(0, $startIndex) + $managedBlock + $oldInstructions.Substring($afterIndex)
    } else {
        throw 'Shared instruction markers are incomplete or duplicated. Repair them before installing.'
    }
    if (Test-Path -LiteralPath (Join-Path $CodexDirectory 'AGENTS.override.md')) {
        Write-Warning 'AGENTS.override.md exists and may take precedence over your personal AGENTS.md.'
    }
}

[IO.Directory]::CreateDirectory($SkillsDirectory) | Out-Null
foreach ($sourceSkill in $sourceSkills) {
    $destination = Join-Path $SkillsDirectory $sourceSkill.Name
    if ($null -eq (Get-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue)) {
        New-Item -ItemType Junction -Path $destination -Target $sourceSkill.FullName | Out-Null
        Write-Host "Linked $($sourceSkill.Name)"
    } else {
        Write-Host "Already linked: $($sourceSkill.Name)"
    }
}

if ($IncludeGlobalInstructions -and $newInstructions -cne $oldInstructions) {
    [IO.Directory]::CreateDirectory($CodexDirectory) | Out-Null
    if (Test-Path -LiteralPath $instructionsPath) {
        $backupPath = $instructionsPath + '.backup-' + [Guid]::NewGuid().ToString('N')
        [IO.File]::Copy($instructionsPath, $backupPath, $false)
        Write-Host "Backed up personal instructions to $backupPath"
    }
    [IO.File]::WriteAllText($instructionsPath, $newInstructions, $utf8)
    Write-Host "Updated shared instructions in $instructionsPath"
} elseif ($IncludeGlobalInstructions) {
    Write-Host 'Shared instructions already up to date.'
}

Write-Host 'Installation complete. If new skills are missing, restart Codex and start a fresh task.'
