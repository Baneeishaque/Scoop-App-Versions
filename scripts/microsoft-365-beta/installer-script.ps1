$preInstallPath = Join-Path $PSScriptRoot 'pre_install.ps1'
if (Test-Path $preInstallPath) {
    Write-Host 'Running pre_install.ps1...'
    . $preInstallPath
} else {
    . "$PSScriptRoot\..\scoop-indep-variables.ps1"
    Set-ScoopIndepVariables -SubFolderPath $PSScriptRoot
}

. "$PSScriptRoot\..\prepare-prereq.ps1"
Initialize-Prereq -DirPath $dir

Start-Process -Wait 7z1900-helper -ArgumentList @('x', '-bso0', "`"$dir\dl.7z_`"", "`"-o$dir`"")
Start-Process -Wait "$dir\setup.exe" -ArgumentList @('/configure', "`"$dir\install-$app.xml`"")
