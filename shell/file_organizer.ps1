# file_organizer.ps1
# Author: khaleeda shaik (Converted to PowerShell)
# This script takes a directory path as an argument, prompts the user for a file extension,
# finds all files with that extension, moves them into a subdirectory organized\<extension>\,
# and displays the results.

param (
    [string]$dirPath = "."
)

# Check if the directory exists
if (-not (Test-Path $dirPath)) {
    Write-Host "Directory not found: $dirPath"
    exit 1
}

# Confirm that the user wants to organize files in the directory
$answer = Read-Host "Do you want to organize files in $dirPath? (y/n)"
if ($answer -ne "y") {
    Write-Host "Exiting..."
    exit 0
}

# Prompt for file extension
$extension = Read-Host "Enter file extension to organize (e.g., txt, sh, log)"

# Create the destination directory (organized\<extension>\) if it doesn't exist
$organizedFolder = Join-Path $dirPath "organized\$extension"
if (-not (Test-Path $organizedFolder)) {
    New-Item -ItemType Directory -Force -Path $organizedFolder | Out-Null
}

# Initialize counter
$count = 0

# Search for files with the given extension and move them
Get-ChildItem -Path $dirPath -Filter "*.$extension" -File | ForEach-Object {
    $sourceFile = $_.FullName
    Move-Item -Path $sourceFile -Destination $organizedFolder
    Write-Host "Moved: $sourceFile -> $organizedFolder"
    $count++
}

# Display summary
Write-Host "Total files moved: $count"
