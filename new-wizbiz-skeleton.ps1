<#
.SYNOPSIS
    Creates the wizbiz-website folder and file skeleton. Empty files only.

.DESCRIPTION
    Creates the directory structure and empty placeholder files. Writes no
    content: filling each file is the work, and that work belongs in a branch
    behind an issue.

    Empty files are deliberate. Git tracks files, not directories, so an empty
    css\ folder would vanish on commit. An empty css\style.css keeps the folder
    in the repository without needing a .gitkeep.

.PARAMETER Path
    Where to create the project. Defaults to .\wizbiz-website

.PARAMETER Force
    Recreate files that already exist, truncating them to zero bytes.

.EXAMPLE
    .\new-wizbiz-skeleton.ps1

.EXAMPLE
    .\new-wizbiz-skeleton.ps1 -Path C:\Projects\wizbiz-website
#>

[CmdletBinding()]
param(
    [string] $Path = "wizbiz-website",
    [switch] $Force
)

$ErrorActionPreference = "Stop"

$dirs = @(
    "css"
    "js"
    "tests"
    "docs"
)

$files = @(
    "index.html"
    "about.html"
    "services.html"
    "contact.html"
    "css\style.css"
    "js\app.js"
    "tests\test-plan.md"
    "docs\deployment.md"
    ".gitignore"
    "README.md"
)

$root = if ([System.IO.Path]::IsPathRooted($Path)) {
    $Path
} else {
    Join-Path (Get-Location).Path $Path
}

Write-Host ""
Write-Host "wizbiz-website skeleton" -ForegroundColor Cyan
Write-Host "Target: $root"
Write-Host ""

if (-not (Test-Path -LiteralPath $root)) {
    New-Item -ItemType Directory -Path $root -Force | Out-Null
}

foreach ($dir in $dirs) {
    $full = Join-Path $root $dir
    if (Test-Path -LiteralPath $full) {
        Write-Host ("  exists  {0}\" -f $dir) -ForegroundColor Yellow
    } else {
        New-Item -ItemType Directory -Path $full -Force | Out-Null
        Write-Host ("  create  {0}\" -f $dir) -ForegroundColor Green
    }
}

$created = 0
$skipped = 0

foreach ($file in $files) {
    $full = Join-Path $root $file

    if ((Test-Path -LiteralPath $full) -and -not $Force) {
        Write-Host ("  exists  {0}" -f $file) -ForegroundColor Yellow
        $skipped++
        continue
    }

    New-Item -ItemType File -Path $full -Force | Out-Null
    Write-Host ("  create  {0}" -f $file) -ForegroundColor Green
    $created++
}

Write-Host ""
Write-Host ("  Created: {0}    Left alone: {1}" -f $created, $skipped)
Write-Host ""
Write-Host "Next:" -ForegroundColor Cyan
Write-Host ("  cd `"{0}`"" -f $root)
Write-Host "  git init --initial-branch=main"
Write-Host "  git add ."
Write-Host "  git commit -m `"chore: add project skeleton`""
Write-Host ""
Write-Host "  Then fill each file from a branch, behind an issue." -ForegroundColor DarkGray
Write-Host ""
