# organize_downloads.ps1
#Requires -Version 5.0

$ErrorActionPreference = "Stop"

$DownloadsPath = "$env:USERPROFILE\Downloads"

$ScriptName = if ($MyInvocation.MyCommand.Path) {
    Split-Path $MyInvocation.MyCommand.Path -Leaf
} else { "" }

Write-Host "Folder: $DownloadsPath"
Write-Host "Sorting files by extension..."

$files = Get-ChildItem -Path $DownloadsPath -File

if ($files.Count -eq 0) {
    Write-Host "No files found."
    exit
}

$moved = 0

foreach ($file in $files) {
    if ($file.Name -eq $ScriptName) { continue }

    $ext = $file.Extension.TrimStart(".").ToUpper()
    if ($ext -eq "") { $ext = "NO_EXTENSION" }

    $targetFolder = Join-Path $DownloadsPath $ext

    if (-not (Test-Path $targetFolder)) {
        New-Item -ItemType Directory -Path $targetFolder | Out-Null
        Write-Host "  Created folder: $ext"
    }

    $destination = Join-Path $targetFolder $file.Name

    if (Test-Path $destination) {
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $newName = "${baseName}_${timestamp}$($file.Extension)"
        $destination = Join-Path $targetFolder $newName
    }

    try {
        Move-Item -Path $file.FullName -Destination $destination -ErrorAction Stop
        Write-Host "  OK: $($file.Name) -> $ext\"
        $moved++
    } catch {
        Write-Host "  ERROR: $($file.Name) — $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Done! Files moved: $moved"
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")