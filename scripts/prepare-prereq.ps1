function Initialize-Prereq {
    param(
        [Parameter(Mandatory = $true)]
        [string]$DirPath
    )
    # Ensure scoop is available
    if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Error 'Scoop is not available in PATH. Exiting.'
        exit 1
    }
    # Manifest path
    $manifestPath = Join-Path (Join-Path $PSScriptRoot '..' 'bucket') ("$script:app.json")
    if (-not (Test-Path $manifestPath)) {
        Write-Error "Manifest $manifestPath not found. Exiting."
        exit 1
    }
    $manifest = Get-Content $manifestPath | ConvertFrom-Json
    $version = $manifest.version
    $url = $manifest.url
    $hash = $manifest.hash
    $depends = $manifest.depends
    Write-Host '--- Manifest values ---'
    Write-Host "Manifest: $manifestPath"
    Write-Host "version: $version"
    Write-Host "url: $url"
    Write-Host "hash: $hash"
    Write-Host "depends: $depends"
    Write-Host '-----------------------'

    # Install dependencies if present
    if ($depends) {
        if ($depends -is [string]) {
            Write-Host "Installing dependency: $depends"
            scoop install $depends | Write-Host
        } elseif ($depends -is [System.Collections.IEnumerable]) {
            foreach ($dep in $depends) {
                Write-Host "Installing dependency: $dep"
                scoop install $dep | Write-Host
            }
        }
    }

    # Download using scoop (force, no update, use manifest)
    Write-Host "Downloading $script:app using scoop..."
    scoop download "$manifestPath" -f -u | Write-Host

    # Find scoop root and cache folder
    $scoopRoot = (scoop prefix scoop) -replace '\\apps\\scoop.*$', ''
    Write-Host "Scoop root: $scoopRoot"
    $cacheFolder = Join-Path $scoopRoot 'cache'
    Write-Host "Cache folder: $cacheFolder"
    Write-Host '--- Cache folder contents ---'
    Get-ChildItem -Path $cacheFolder | Write-Host
    Write-Host '-----------------------------'
    # Find cache files for this app/version
    $cacheFiles = Get-ChildItem -Path $cacheFolder -Filter ("$script:app#$version#*")
    Write-Host '--- Cache files for app ---'
    $cacheFiles | Write-Host
    Write-Host '--------------------------'
    if ($cacheFiles.Count -eq 0) {
        Write-Error "No cache file found for $script:app $version. Exiting."
        exit 1
    }
    if ($cacheFiles.Count -gt 1) {
        Write-Error "Multiple cache files found for $script:app $version. Exiting."
        exit 1
    }
    $cacheFile = $cacheFiles[0]
    Write-Host "Using cache file: $($cacheFile.FullName)"
    # Check hash
    $actualHash = (Get-FileHash $cacheFile.FullName -Algorithm SHA256).Hash.ToLower()
    if ($actualHash -ne $hash.ToLower()) {
        Write-Error "Hash mismatch! Manifest: $hash, Actual: $actualHash. Exiting."
        exit 1
    }
    # Determine output file name
    $outputFile = ''
    if ($url -match '#/(.+)$') {
        $outputFile = $Matches[1]
    } else {
        $outputFile = [System.IO.Path]::GetFileName($url)
    }
    $destPath = Join-Path $DirPath $outputFile
    Copy-Item $cacheFile.FullName $destPath -Force
    if (-not (Test-Path $destPath)) {
        Write-Error "Failed to copy $($cacheFile.FullName) to $destPath. Exiting."
        exit 1
    }
    Write-Host "Copied $($cacheFile.FullName) to $destPath"
}
