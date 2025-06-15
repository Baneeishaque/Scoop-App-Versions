$ranInit = $false
if (-not $script:preInstallScriptRun) {

    $preInstallScriptPath = Join-Path $PSScriptRoot 'pre_install.ps1'
    if (Test-Path $preInstallScriptPath) {
        Write-Host 'Running pre_install.ps1'
        . $preInstallScriptPath
        $ranInit = $true
    }
}

if (-not $script:installerScriptRun) {

    $installerScriptPath = Join-Path $PSScriptRoot 'installer-script.ps1'
    if (Test-Path $installerScriptPath) {
        Write-Host 'Running installer-script.ps1'
        . $installerScriptPath
        $ranInit = $true
    }
}

if (-not $ranInit) {

    if (-not $script:ScoopVariablesInitialized) {
        Set-ScoopVariables -SubFolderPath $PSScriptRoot
        . "$PSScriptRoot\..\scoop-variables-for-manifest-script-independent-run.ps1"
    }
}

Start-Process -Wait "$dir\setup.exe" -ArgumentList @('/configure', "`"$dir\uninstall-microsoft-365.xml`"")
