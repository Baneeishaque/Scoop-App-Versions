$preInstallPath = Join-Path $PSScriptRoot 'pre_install.ps1'
if (Test-Path $preInstallPath) {
    Write-Host 'Running pre_install.ps1...'
    . $preInstallPath
} else {
    . "$PSScriptRoot\..\scoop-variables-for-manifest-script-independent-run.ps1"
    Set-ScoopVariables -SubFolderPath $PSScriptRoot
}

. "$PSScriptRoot\..\prepare-installer-script-prerequisites.ps1"
Initialize-InstallerScriptPrerequisites -DirPath $dir

Start-Process -Wait 7z1900-helper -ArgumentList @('x', '-bso0', "`"$dir\dl.7z_`"", "`"-o$dir`"")
Start-Process -Wait "$dir\setup.exe" -ArgumentList @('/configure', "`"$dir\install-$app.xml`"")
