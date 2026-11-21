# Links every addon in this repo into the game's AddOns folder as a directory junction,
# so edits here are live after /reload. Safe to run repeatedly.
# An addon is any top-level folder containing <FolderName>.toc.

$AddOnsDir = "C:\Program Files (x86)\World of Warcraft\_forever_\Interface\AddOns"
$RepoDir = $PSScriptRoot

if (-not (Test-Path $AddOnsDir)) {
    Write-Error "AddOns folder not found: $AddOnsDir"
    exit 1
}

foreach ($dir in Get-ChildItem $RepoDir -Directory) {
    $toc = Join-Path $dir.FullName "$($dir.Name).toc"
    if (-not (Test-Path $toc)) { continue }

    $target = Join-Path $AddOnsDir $dir.Name
    $existing = Get-Item $target -ErrorAction SilentlyContinue

    if ($null -eq $existing) {
        New-Item -ItemType Junction -Path $target -Target $dir.FullName | Out-Null
        Write-Host "Linked   $($dir.Name)"
    } elseif ($existing.LinkType -eq "Junction") {
        Write-Host "OK       $($dir.Name) (already linked)"
    } else {
        Write-Warning "Skipped  $($dir.Name): a real folder with that name already exists in AddOns. Move or delete it first."
    }
}
