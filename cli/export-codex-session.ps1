[CmdletBinding()]
param(
    [string]$TaskId = $env:CODEX_SESSION_ID,
    [string]$CodexHome = (Join-Path $env:USERPROFILE ".codex"),
    [string]$DestinationDirectory = [Environment]::GetFolderPath("Desktop"),
    [bool]$IncludeArchived = $true,
    [bool]$CreateZip = $true,
    [string]$OutputName = ""
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Get-OptionalProperty {
    param(
        [AllowNull()][object]$Object,
        [Parameter(Mandatory = $true)][string]$Name
    )
    if ($null -eq $Object) { return $null }
    $property = $Object.PSObject.Properties[$Name]
    if ($property) { return $property.Value }
    return $null
}

function Get-ShortHash {
    param([Parameter(Mandatory = $true)][string]$Value)

    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    try {
        return [System.BitConverter]::ToString(
            $sha256.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Value))
        ).Replace("-", "").Substring(0, 12).ToLowerInvariant()
    } finally {
        $sha256.Dispose()
    }
}

if (-not $TaskId) {
    $TaskId = $env:CODEX_THREAD_ID
}
if (-not $TaskId) {
    $TaskId = $env:SESSION_ID
}
if (-not $TaskId) {
    throw "TaskId is required when CODEX_SESSION_ID, CODEX_THREAD_ID, and SESSION_ID are unavailable."
}
if (-not $DestinationDirectory) {
    $DestinationDirectory = (Get-Location).Path
}

$CodexHome = [System.IO.Path]::GetFullPath($CodexHome)
$DestinationDirectory = [System.IO.Path]::GetFullPath($DestinationDirectory)
if (-not (Test-Path -LiteralPath $CodexHome -PathType Container)) {
    throw "Codex data directory was not found: $CodexHome"
}
New-Item -ItemType Directory -Force -Path $DestinationDirectory | Out-Null

$sessionRoots = @((Join-Path $CodexHome "sessions"))
if ($IncludeArchived) {
    $sessionRoots += Join-Path $CodexHome "archived_sessions"
}

$sessionFiles = foreach ($root in $sessionRoots) {
    if (Test-Path -LiteralPath $root -PathType Container) {
        Get-ChildItem -LiteralPath $root -Filter "*.jsonl" -File -Recurse
    }
}

$recordsById = @{}
foreach ($file in ($sessionFiles | Sort-Object LastWriteTimeUtc -Descending)) {
    try {
        $reader = [System.IO.StreamReader]::new(
            $file.FullName,
            [System.Text.Encoding]::UTF8,
            $true
        )
        try {
            $metadata = ($reader.ReadLine() | ConvertFrom-Json).payload
        } finally {
            $reader.Dispose()
        }
        $id = [string]$metadata.id
        if (-not $id -or $recordsById.ContainsKey($id)) { continue }
        $source = Get-OptionalProperty $metadata "source"
        $subagent = Get-OptionalProperty $source "subagent"
        $spawn = Get-OptionalProperty $subagent "thread_spawn"
        $recordsById[$id] = [PSCustomObject]@{
            Id = $id
            ParentId = [string](Get-OptionalProperty $spawn "parent_thread_id")
            AgentPath = [string](Get-OptionalProperty $spawn "agent_path")
            File = $file.FullName
            Archived = $file.FullName.StartsWith(
                (Join-Path $CodexHome "archived_sessions"),
                [System.StringComparison]::OrdinalIgnoreCase
            )
        }
    } catch {
        Write-Verbose "Skipping unreadable session metadata: $($file.FullName)"
    }
}

if (-not $recordsById.ContainsKey($TaskId)) {
    throw "Task $TaskId was not found under $CodexHome."
}

$selectedIds = [System.Collections.Generic.HashSet[string]]::new(
    [System.StringComparer]::OrdinalIgnoreCase
)
[void]$selectedIds.Add($TaskId)
do {
    $added = $false
    foreach ($record in $recordsById.Values) {
        if ($record.ParentId -and $selectedIds.Contains($record.ParentId)) {
            if ($selectedIds.Add($record.Id)) { $added = $true }
        }
    }
} while ($added)

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss-fff"
if ($OutputName) {
    if ([System.IO.Path]::GetFileName($OutputName) -ne $OutputName) {
        throw "OutputName must be a file-name-safe value, not a path."
    }
    $baseName = $OutputName
} else {
    $safeTaskId = ($TaskId -replace "[^A-Za-z0-9._-]", "-").Trim(".", "-")
    if (-not $safeTaskId) { $safeTaskId = "task" }
    if ($safeTaskId.Length -gt 32) { $safeTaskId = $safeTaskId.Substring(0, 32) }
    $baseName = "codex-session-$safeTaskId-$(Get-ShortHash $TaskId)-$timestamp"
}

$exportFolder = Join-Path $DestinationDirectory $baseName
$zipPath = Join-Path $exportFolder "logs.zip"
$stagingFolder = Join-Path $DestinationDirectory (".codex-" + [guid]::NewGuid().ToString("N") + ".tmp")
$stagingZipPath = "$stagingFolder.zip"
if (Test-Path -LiteralPath $exportFolder) {
    throw "Export destination already exists: $exportFolder"
}
try {
    New-Item -ItemType Directory -Path $stagingFolder | Out-Null

    $manifestLogs = foreach ($record in ($recordsById.Values | Where-Object {
        $selectedIds.Contains($_.Id)
    } | Sort-Object AgentPath, Id)) {
        $label = if ($record.AgentPath) { $record.AgentPath.Trim("/") } else { "root" }
        $safeLabel = ($label -replace "[^A-Za-z0-9._-]", "-").Trim(".", "-")
        if (-not $safeLabel) { $safeLabel = "root" }
        if ($safeLabel.Length -gt 24) { $safeLabel = $safeLabel.Substring(0, 24) }
        $safeId = ([string]$record.Id -replace "[^A-Za-z0-9._-]", "-").Trim(".", "-")
        if (-not $safeId) { $safeId = "session" }
        if ($safeId.Length -gt 32) { $safeId = $safeId.Substring(0, 32) }
        $idHash = Get-ShortHash ([string]$record.Id)
        $targetName = "$safeLabel-$safeId-$idHash.jsonl"
        Copy-Item -LiteralPath $record.File -Destination (Join-Path $stagingFolder $targetName)
        [PSCustomObject]@{
            session_id = $record.Id
            parent_session_id = $record.ParentId
            agent_path = $record.AgentPath
            archived = $record.Archived
            exported_file = $targetName
        }
    }

    $manifestPath = Join-Path $stagingFolder "manifest.json"
    [PSCustomObject]@{
        task_id = $TaskId
        exported_at_utc = [DateTime]::UtcNow.ToString("o")
        include_archived = $IncludeArchived
        log_count = @($manifestLogs).Count
        logs = @($manifestLogs)
    } | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $manifestPath -Encoding UTF8

    if ($CreateZip) {
        Compress-Archive -Path (Join-Path $stagingFolder "*") -DestinationPath $stagingZipPath
        [System.IO.File]::Move($stagingZipPath, (Join-Path $stagingFolder "logs.zip"))
    }

    [System.IO.Directory]::Move($stagingFolder, $exportFolder)
} catch {
    if (Test-Path -LiteralPath $stagingZipPath) {
        Remove-Item -LiteralPath $stagingZipPath -Force
    }
    if (Test-Path -LiteralPath $stagingFolder) {
        Remove-Item -LiteralPath $stagingFolder -Recurse -Force
    }
    throw
}

Write-Warning "Raw Codex logs may contain credentials, access tokens, secrets, personal or PII data, prompts, command output, paths, and file contents. Review and redact them before sharing."
[PSCustomObject]@{
    TaskId = $TaskId
    LogCount = @($manifestLogs).Count
    Folder = $exportFolder
    Zip = if ($CreateZip) { $zipPath } else { $null }
}
