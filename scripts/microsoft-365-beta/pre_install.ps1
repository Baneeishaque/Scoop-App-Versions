if (Get-Variable -Name version -Scope Script -ErrorAction SilentlyContinue) {

    $script:ScoopVariablesInitialized = $true

} else {

    . "$PSScriptRoot\..\scoop-variables-for-manifest-script-independent-run.ps1"
    Set-ScoopVariables -SubFolderPath $PSScriptRoot
}

$script:preInstallScriptRun = $true

$scriptdir = "$bucketsdir\$bucket\scripts"
if (-not (Test-Path -Path $scriptdir)) {
    Write-Error "Script directory $scriptdir does not exist. Exiting."
    exit 1
}
if ($architecture -eq '64bit') {
    (Get-Content "$scriptdir\microsoft-365-beta\install-$app.xml").Replace('{buildNumber}', $version) | Set-Content -Path "$dir\install-$app.xml"
} elseif ($architecture -eq '32bit') {
    (Get-Content "$scriptdir\microsoft-365-beta\install-$app.xml").Replace('{buildNumber}', $version).Replace('64', '32') | Set-Content -Path "$dir\install-$app.xml"
}
Copy-Item "$scriptdir\microsoft-365-beta\uninstall-microsoft-365.xml" "$dir\"
