. "$PSScriptRoot\..\scoop-variables-for-manifest-script-independent-run.ps1"

$ranInit = $false
$preInstallScriptPath = Join-Path $PSScriptRoot 'pre_install.ps1'
$installerScriptPath = Join-Path $PSScriptRoot 'installer-script.ps1'

if (Test-Path $preInstallScriptPath) {
    Write-Host 'Running pre_install.ps1'
    . $preInstallScriptPath
    $ranInit = $true
}

if (Test-Path $installerScriptPath) {
    Write-Host 'Running installer-script.ps1'
    . $installerScriptPath
    $ranInit = $true
}

if (-not $ranInit) {
    Set-ScoopVariables -SubFolderPath $PSScriptRoot
}

Start-Process -Wait "$dir\setup.exe" -ArgumentList @('/configure', "`"$dir\uninstall-microsoft-365.xml`"")
