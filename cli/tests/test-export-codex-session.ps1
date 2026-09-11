$ErrorActionPreference = "Stop"

$ScriptUnderTest = [System.IO.Path]::GetFullPath(
    (Join-Path $PSScriptRoot "..\export-codex-session.ps1")
)
$TempBase = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$TestRoot = Join-Path $TempBase ("codex-export-test-" + [guid]::NewGuid().ToString("N"))
$CodexHome = Join-Path $TestRoot ".codex"
$Destination = Join-Path $TestRoot "exports"
$TaskId = "root-task-id"
$OriginalThreadId = $env:CODEX_THREAD_ID
$OriginalSessionId = $env:CODEX_SESSION_ID
$OriginalGenericSessionId = $env:SESSION_ID

function Write-TestSession {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Id,
        [string]$ParentId = "",
        [string]$AgentPath = ""
    )

    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Path) | Out-Null
    $source = if ($ParentId) {
        @{
            subagent = @{
                thread_spawn = @{
                    parent_thread_id = $ParentId
                    agent_path = $AgentPath
                }
            }
        }
    } else {
        "app"
    }
    $line = @{
        type = "session_meta"
        payload = @{
            id = $Id
            source = $source
        }
    } | ConvertTo-Json -Compress -Depth 6
    $contents = $line + "`r`n" + '{"type":"event","payload":{"ok":true}}' + "`r`n"
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $contents, $utf8NoBom)
}

function Assert-Throws {
    param(
        [Parameter(Mandatory = $true)][scriptblock]$Action,
        [Parameter(Mandatory = $true)][string]$MessagePattern
    )
    try {
        & $Action
    } catch {
        if ([string]$_.Exception.Message -notmatch $MessagePattern) { throw }
        return
    }
    throw "Expected command to fail with: $MessagePattern"
}

function Wait-ForStagingFolder {
    param(
        [Parameter(Mandatory = $true)][string]$DestinationDirectory,
        [Parameter(Mandatory = $true)][System.Management.Automation.Job]$Job
    )

    $deadline = [DateTime]::UtcNow.AddSeconds(30)
    do {
        $folder = Get-ChildItem -LiteralPath $DestinationDirectory -Directory |
            Where-Object { $_.Name -like ".codex-*.tmp" } |
            Select-Object -First 1
        if ($folder) { return $folder }
        if ($Job.State -ne "Running") {
            throw "Export stopped before its staging folder could be observed"
        }
        Start-Sleep -Milliseconds 5
    } while ([DateTime]::UtcNow -lt $deadline)
    throw "Timed out waiting for the export staging folder"
}

New-Item -ItemType Directory -Force -Path $TestRoot | Out-Null
try {
    Write-TestSession -Path (Join-Path $CodexHome "sessions\root.jsonl") -Id $TaskId
    Write-TestSession -Path (Join-Path $CodexHome "sessions\child.jsonl") `
        -Id "child-id" -ParentId $TaskId -AgentPath "/root/child"
    Write-TestSession -Path (Join-Path $CodexHome "archived_sessions\nested.jsonl") `
        -Id "nested-id" -ParentId "child-id" -AgentPath "/root/child/nested"
    Write-TestSession -Path (Join-Path $CodexHome "sessions\unrelated.jsonl") `
        -Id "unrelated-id"
    Set-Content -LiteralPath (Join-Path $CodexHome "sessions\malformed.jsonl") `
        -Value "not JSON session metadata"

    $result = & $ScriptUnderTest -TaskId $TaskId -CodexHome $CodexHome `
        -DestinationDirectory $Destination -IncludeArchived $true -CreateZip $true `
        -WarningVariable ExportWarnings

    if ($result.LogCount -ne 3) { throw "Expected 3 logs, got $($result.LogCount)" }
    if (-not (Test-Path -LiteralPath $result.Folder -PathType Container)) {
        throw "Export folder was not created"
    }
    if (-not (Test-Path -LiteralPath $result.Zip -PathType Leaf)) {
        throw "Export ZIP was not created"
    }
    if ((Split-Path -Parent $result.Zip) -ne $result.Folder -or
        (Split-Path -Leaf $result.Zip) -ne "logs.zip") {
        throw "Export ZIP was not published inside the final folder"
    }
    $warningText = [string]$ExportWarnings
    if ($warningText -notmatch "credentials" -or
        $warningText -notmatch "access tokens" -or
        $warningText -notmatch "secrets" -or
        $warningText -notmatch "personal or PII data") {
        throw "Credential, secret, and personal-data warning was not emitted"
    }

    $logs = @(Get-ChildItem -LiteralPath $result.Folder -Filter "*.jsonl" -File)
    if ($logs.Count -ne 3) { throw "Expected 3 copied JSONL files, got $($logs.Count)" }
    if ($logs.Name -match "unrelated") { throw "Unrelated session was exported" }

    $manifest = Get-Content -LiteralPath (Join-Path $result.Folder "manifest.json") -Raw |
        ConvertFrom-Json
    if ($manifest.task_id -ne $TaskId) { throw "Manifest task ID is incorrect" }
    if ($manifest.logs.Count -ne 3) { throw "Manifest log count is incorrect" }

    $withoutArchives = & $ScriptUnderTest -TaskId $TaskId -CodexHome $CodexHome `
        -DestinationDirectory $Destination -OutputName "without-archives" `
        -IncludeArchived $false -CreateZip $false
    if ($withoutArchives.LogCount -ne 2) {
        throw "Archived nested agent was not excluded"
    }
    if ($withoutArchives.Zip) { throw "ZIP was created when disabled" }

    Assert-Throws -MessagePattern "already exists" -Action {
        & $ScriptUnderTest -TaskId $TaskId -CodexHome $CodexHome `
            -DestinationDirectory $Destination -OutputName "without-archives" `
            -CreateZip $false
    }

    $collisionFolder = Join-Path $Destination "folder-collision"
    New-Item -ItemType Directory -Path $collisionFolder | Out-Null
    $collisionSentinel = Join-Path $collisionFolder "sentinel.txt"
    Set-Content -LiteralPath $collisionSentinel -Value "preserve me"
    Assert-Throws -MessagePattern "already exists" -Action {
        & $ScriptUnderTest -TaskId $TaskId -CodexHome $CodexHome `
            -DestinationDirectory $Destination -OutputName "folder-collision" `
            -CreateZip $true
    }
    if ((Get-Content -LiteralPath $collisionSentinel -Raw).Trim() -ne "preserve me") {
        throw "Existing export folder was modified"
    }
    if (@(Get-ChildItem -LiteralPath $collisionFolder).Count -ne 1) {
        throw "Artifacts were added to an existing export folder"
    }

    $unicodeHome = Join-Path $TestRoot "unicode-codex"
    $unicodeRootId = "røøt-日本語-🧪"
    $unicodeChildId = "chïld-資料-🚀"
    $unicodeAgentPath = "/root/設計-équipe"
    $unicodeRootSource = Join-Path $unicodeHome "sessions\root.jsonl"
    $unicodeChildSource = Join-Path $unicodeHome "sessions\child.jsonl"
    Write-TestSession -Path $unicodeRootSource -Id $unicodeRootId
    Write-TestSession -Path $unicodeChildSource -Id $unicodeChildId `
        -ParentId $unicodeRootId -AgentPath $unicodeAgentPath
    $unicodeBytes = [System.IO.File]::ReadAllBytes($unicodeRootSource)
    if ($unicodeBytes.Length -ge 3 -and $unicodeBytes[0] -eq 0xEF -and
        $unicodeBytes[1] -eq 0xBB -and $unicodeBytes[2] -eq 0xBF) {
        throw "Unicode fixture unexpectedly contains a UTF-8 BOM"
    }

    $unicodeResult = & $ScriptUnderTest -TaskId $unicodeRootId `
        -CodexHome $unicodeHome -DestinationDirectory $Destination `
        -OutputName "unicode-metadata" -IncludeArchived $false -CreateZip $false
    $unicodeManifest = Get-Content -LiteralPath `
        (Join-Path $unicodeResult.Folder "manifest.json") -Raw -Encoding UTF8 |
        ConvertFrom-Json
    $unicodeChild = @($unicodeManifest.logs | Where-Object {
        $_.session_id -eq $unicodeChildId
    })
    if ($unicodeManifest.task_id -ne $unicodeRootId -or $unicodeChild.Count -ne 1 -or
        $unicodeChild[0].parent_session_id -ne $unicodeRootId -or
        $unicodeChild[0].agent_path -ne $unicodeAgentPath) {
        throw "UTF-8 Unicode session metadata was not preserved"
    }

    $hostilePrefix = "x" * 240
    $hostileIds = @("$hostilePrefix/path", "$hostilePrefix\path")
    $hostileFiles = @(
        (Join-Path $CodexHome "sessions\hostile-one.jsonl"),
        (Join-Path $CodexHome "sessions\hostile-two.jsonl")
    )
    $hostileAgentPath = "/root/" + ("oversized-segment/" * 16) + "leaf"
    Write-TestSession -Path $hostileFiles[0] -Id $hostileIds[0] `
        -ParentId $TaskId -AgentPath $hostileAgentPath
    Write-TestSession -Path $hostileFiles[1] -Id $hostileIds[1] `
        -ParentId $TaskId -AgentPath "/root/hostile-two"

    $hostileResult = & $ScriptUnderTest -TaskId $TaskId -CodexHome $CodexHome `
        -DestinationDirectory $Destination -OutputName "hostile-identifiers" `
        -CreateZip $false
    $hostileManifest = Get-Content -LiteralPath `
        (Join-Path $hostileResult.Folder "manifest.json") -Raw | ConvertFrom-Json
    $hostileLogs = @($hostileManifest.logs | Where-Object {
        $hostileIds -contains $_.session_id
    })
    if ($hostileLogs.Count -ne 2) {
        throw "Hostile session IDs were not preserved in the manifest"
    }
    if (@($hostileLogs.exported_file | Select-Object -Unique).Count -ne 2) {
        throw "Sanitized session filenames collided"
    }
    foreach ($entry in $hostileLogs) {
        if ([System.IO.Path]::GetFileName($entry.exported_file) -ne $entry.exported_file) {
            throw "Hostile session ID escaped the export folder"
        }
        if ($entry.exported_file.Length -gt 160) {
            throw "Exported session filename was not bounded"
        }
        if (-not (Test-Path -LiteralPath (Join-Path $hostileResult.Folder $entry.exported_file) -PathType Leaf)) {
            throw "Sanitized session file was not exported"
        }
    }
    Remove-Item -LiteralPath $hostileFiles -Force

    $longTaskHome = Join-Path $TestRoot "long-task-codex"
    $longTaskId = ("long-root-segment/" * 20) + "../leaf"
    Write-TestSession -Path (Join-Path $longTaskHome "sessions\root.jsonl") `
        -Id $longTaskId
    $longTaskResult = & $ScriptUnderTest -TaskId $longTaskId `
        -CodexHome $longTaskHome -DestinationDirectory $Destination `
        -IncludeArchived $false -CreateZip $false
    $longTaskFolderName = [System.IO.Path]::GetFileName($longTaskResult.Folder)
    if ($longTaskFolderName.Length -gt 128) {
        throw "Default export folder name was not bounded"
    }
    if ([System.IO.Path]::GetFileName($longTaskFolderName) -ne $longTaskFolderName) {
        throw "Path-like task ID escaped the destination directory"
    }
    $longTaskManifest = Get-Content -LiteralPath `
        (Join-Path $longTaskResult.Folder "manifest.json") -Raw | ConvertFrom-Json
    if ($longTaskManifest.task_id -ne $longTaskId -or
        $longTaskManifest.logs[0].session_id -ne $longTaskId) {
        throw "Long root task ID was not preserved in the manifest"
    }

    $raceHome = Join-Path $TestRoot "race-codex"
    $raceTaskId = "race-root-id"
    $raceSource = Join-Path $raceHome "sessions\root.jsonl"
    Write-TestSession -Path $raceSource -Id $raceTaskId
    $largeSource = [System.IO.File]::Open(
        $raceSource,
        [System.IO.FileMode]::Open,
        [System.IO.FileAccess]::Write,
        [System.IO.FileShare]::Read
    )
    try {
        $largeSource.SetLength(128MB)
    } finally {
        $largeSource.Dispose()
    }

    $raceOutputName = "destination-race"
    $raceJob = Start-Job -ScriptBlock {
        param($ScriptPath, $Id, $CodexData, $DestinationPath, $Name)
        & $ScriptPath -TaskId $Id -CodexHome $CodexData `
            -DestinationDirectory $DestinationPath -OutputName $Name `
            -IncludeArchived $false -CreateZip $false
    } -ArgumentList $ScriptUnderTest, $raceTaskId, $raceHome, $Destination, $raceOutputName
    try {
        [void](Wait-ForStagingFolder -DestinationDirectory $Destination -Job $raceJob)
        $raceFinalFolder = Join-Path $Destination $raceOutputName
        New-Item -ItemType Directory -Path $raceFinalFolder | Out-Null
        $raceSentinel = Join-Path $raceFinalFolder "sentinel.txt"
        Set-Content -LiteralPath $raceSentinel -Value "preserve me"

        [void](Wait-Job -Job $raceJob -Timeout 30)
        if ($raceJob.State -eq "Running") {
            Stop-Job -Job $raceJob
            throw "Destination-race export did not finish"
        }
        [void](Receive-Job -Job $raceJob -ErrorAction SilentlyContinue)
        if ($raceJob.State -ne "Failed") {
            throw "Exporter did not reject a destination created during export"
        }
        if ((Get-Content -LiteralPath $raceSentinel -Raw).Trim() -ne "preserve me") {
            throw "Exporter modified the competing destination sentinel"
        }
        if (@(Get-ChildItem -LiteralPath $raceFinalFolder).Count -ne 1) {
            throw "Exporter added artifacts to the competing destination"
        }
    } finally {
        if ($raceJob.State -eq "Running") { Stop-Job -Job $raceJob }
        Remove-Job -Job $raceJob -Force
    }

    $lockedHome = Join-Path $TestRoot "locked-codex"
    $lockedTaskId = "locked-root-id"
    $lockedRootSource = Join-Path $lockedHome "sessions\root.jsonl"
    $lockedChildSource = Join-Path $lockedHome "sessions\child.jsonl"
    Write-TestSession -Path $lockedRootSource -Id $lockedTaskId
    Write-TestSession -Path $lockedChildSource -Id "locked-child-id" `
        -ParentId $lockedTaskId -AgentPath "/root/zzzz-locked"
    $largeSource = [System.IO.File]::Open(
        $lockedRootSource,
        [System.IO.FileMode]::Open,
        [System.IO.FileAccess]::Write,
        [System.IO.FileShare]::Read
    )
    try {
        $largeSource.SetLength(128MB)
    } finally {
        $largeSource.Dispose()
    }

    $lockedOutputName = "retry-after-locked-copy"
    $lockedJob = Start-Job -ScriptBlock {
        param($ScriptPath, $Id, $CodexData, $DestinationPath, $Name)
        & $ScriptPath -TaskId $Id -CodexHome $CodexData `
            -DestinationDirectory $DestinationPath -OutputName $Name `
            -IncludeArchived $false -CreateZip $true
    } -ArgumentList $ScriptUnderTest, $lockedTaskId, $lockedHome, $Destination, $lockedOutputName
    $sourceLock = $null
    try {
        [void](Wait-ForStagingFolder -DestinationDirectory $Destination -Job $lockedJob)
        $sourceLock = [System.IO.File]::Open(
            $lockedChildSource,
            [System.IO.FileMode]::Open,
            [System.IO.FileAccess]::ReadWrite,
            [System.IO.FileShare]::None
        )

        [void](Wait-Job -Job $lockedJob -Timeout 30)
        if ($lockedJob.State -eq "Running") {
            Stop-Job -Job $lockedJob
            throw "Locked-source export did not finish"
        }
        [void](Receive-Job -Job $lockedJob -ErrorAction SilentlyContinue)
        if ($lockedJob.State -ne "Failed") {
            throw "Locked source did not fail during export copy"
        }
    } finally {
        if ($sourceLock) { $sourceLock.Dispose() }
        if ($lockedJob.State -eq "Running") { Stop-Job -Job $lockedJob }
        Remove-Job -Job $lockedJob -Force
    }

    $lockedFinalFolder = Join-Path $Destination $lockedOutputName
    $lockedFinalZip = Join-Path $lockedFinalFolder "logs.zip"
    if (Test-Path -LiteralPath $lockedFinalFolder) {
        throw "Failed locked-source export left its final folder behind"
    }
    if (Test-Path -LiteralPath $lockedFinalZip) {
        throw "Failed locked-source export left its final ZIP behind"
    }

    $lockedRetry = & $ScriptUnderTest -TaskId $lockedTaskId -CodexHome $lockedHome `
        -DestinationDirectory $Destination -OutputName $lockedOutputName `
        -IncludeArchived $false -CreateZip $true
    if (-not (Test-Path -LiteralPath $lockedRetry.Folder -PathType Container)) {
        throw "Retry after locked-source failure did not create the final folder"
    }
    if (-not (Test-Path -LiteralPath $lockedRetry.Zip -PathType Leaf)) {
        throw "Retry after locked-source failure did not create the final ZIP"
    }

    Assert-Throws -MessagePattern "must be a file-name-safe value" -Action {
        & $ScriptUnderTest -TaskId $TaskId -CodexHome $CodexHome `
            -DestinationDirectory $Destination -OutputName "..\unsafe" -CreateZip $false
    }

    $env:CODEX_THREAD_ID = "child-id"
    $env:CODEX_SESSION_ID = $TaskId
    $defaultResult = & $ScriptUnderTest -CodexHome $CodexHome `
        -DestinationDirectory $Destination -OutputName "default-selection" `
        -IncludeArchived $true -CreateZip $false
    if ($defaultResult.TaskId -ne $TaskId) {
        throw "Default export did not select the root Codex session"
    }
    if ($defaultResult.LogCount -ne 3) {
        throw "Default export omitted part of the agent tree"
    }

    $env:CODEX_THREAD_ID = $null
    $env:CODEX_SESSION_ID = $null
    $env:SESSION_ID = $TaskId
    $fallbackResult = & $ScriptUnderTest -CodexHome $CodexHome `
        -DestinationDirectory $Destination -OutputName "generic-session-fallback" `
        -IncludeArchived $true -CreateZip $false
    if ($fallbackResult.TaskId -ne $TaskId) {
        throw "SESSION_ID fallback was not used"
    }

    $env:SESSION_ID = $null
    Assert-Throws -MessagePattern "TaskId is required" -Action {
        & $ScriptUnderTest -CodexHome $CodexHome -DestinationDirectory $Destination `
            -OutputName "missing-id" -CreateZip $false
    }

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $archive = [System.IO.Compression.ZipFile]::OpenRead($result.Zip)
    try {
        $zipLogs = @($archive.Entries | Where-Object { $_.FullName -like "*.jsonl" })
        if ($zipLogs.Count -ne 3) { throw "ZIP does not contain all three logs" }
    } finally {
        $archive.Dispose()
    }

    Write-Host "export-codex-session tests passed"
} finally {
    $env:CODEX_THREAD_ID = $OriginalThreadId
    $env:CODEX_SESSION_ID = $OriginalSessionId
    $env:SESSION_ID = $OriginalGenericSessionId
    $resolvedTestRoot = [System.IO.Path]::GetFullPath($TestRoot)
    if (-not $resolvedTestRoot.StartsWith($TempBase, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove test data outside the system temp directory"
    }
    if (Test-Path -LiteralPath $resolvedTestRoot) {
        Remove-Item -LiteralPath $resolvedTestRoot -Recurse -Force
    }
}
