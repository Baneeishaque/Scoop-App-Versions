# region: Scoop-independent variable definitions
function Set-ScoopIndepVariables {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SubFolderPath
    )
    if ($script:ScoopIndepVariablesInitialized) {
        Write-Host 'ScoopIndepVariables already initialized, skipping.'
        return
    }
    $script:ScoopIndepVariablesInitialized = $true
    if (-not (Get-Variable -Name bucketsdir -Scope Script -ErrorAction SilentlyContinue)) {
        $script:bucketsdir = Resolve-Path (Join-Path $PSScriptRoot '..')
    }

    # $bucket is not needed, set to empty string if not defined
    if (-not (Get-Variable -Name bucket -Scope Script -ErrorAction SilentlyContinue)) {
        $script:bucket = ''
    }

    # Detect architecture if not set
    if (-not (Get-Variable -Name architecture -Scope Script -ErrorAction SilentlyContinue)) {
        # User-editable constant
        $script:architecture = '' # Set to '64bit' or '32bit' to override auto-detection
        if ([string]::IsNullOrWhiteSpace($script:architecture)) {
            try {
                $arch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture
                if ($arch -match '64') { $script:architecture = '64bit' } else { $script:architecture = '32bit' }
            } catch { $script:architecture = '64bit' }
        }
    }

    # $dir for independent run
    if (-not (Get-Variable -Name dir -Scope Script -ErrorAction SilentlyContinue)) {
        $script:dir = Join-Path $SubFolderPath 'dir'
        if (Test-Path $script:dir) {
            Remove-Item -Path $script:dir -Recurse -Force
        }
        if (-not (Test-Path $script:dir)) {
            New-Item -ItemType Directory -Path $script:dir | Out-Null
        }
    }

    # $app selection logic
    if (-not (Get-Variable -Name app -Scope Script -ErrorAction SilentlyContinue)) {
        # User-editable constant
        $script:app = '' # Set to the app name (e.g., 'microsoft-365-access-excel-one-drive-outlook-power-point-teams-word-visio-project-beta')

        if ([string]::IsNullOrWhiteSpace($script:app)) {

            $xmlFiles = Get-ChildItem -Path $SubFolderPath -Filter 'install-*.xml' | Select-Object -ExpandProperty Name
            if ($xmlFiles.Count -eq 0) {
                Write-Error "No install-*.xml files found in $SubFolderPath. Exiting."
                exit 1
            }

            $firstXml = $xmlFiles | Select-Object -First 1
            $script:app = ($firstXml -replace '^install-(.*)\.xml$', '$1')
            Write-Host "No app specified. Using first found: $script:app"

        } elseif (-not ($xmlFiles -contains "install-$script:app.xml")) {

            Write-Error "install-$script:app.xml not found in $SubFolderPath. Exiting."
            exit 1
        }
    }

    # $version must be set by user
    if (-not (Get-Variable -Name version -Scope Script -ErrorAction SilentlyContinue)) {
        $script:version = '19009.20000' # Set to the version string (e.g., '19009.20000')

        if ([string]::IsNullOrWhiteSpace($script:version)) {
            Write-Error 'Version must be specified in the script. Exiting.'
            exit 1
        }

        # Print out variables for user convenience
        Write-Host '--- Variable values ---'
        Write-Host "SubFolderPath: $SubFolderPath"
        Write-Host "scriptdir: $PSScriptRoot"
        Write-Host "bucketsdir: $script:bucketsdir"
        Write-Host "bucket: $script:bucket"
        Write-Host "architecture: $script:architecture"
        Write-Host "dir: $script:dir"
        Write-Host "xmlFiles: $xmlFiles"
        Write-Host "app: $script:app"
        Write-Host "version: $script:version"
        Write-Host '-----------------------'
    }
}
# endregion
