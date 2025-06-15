$url2 = 'https://www.microsoft.com/en-us/download/details.aspx?id=49117'
$regex2 = 'download/([\w/-]+)(officedeploymenttool_[\d-]+\.exe)'
$cont = $(Invoke-WebRequest $url2).Content
if (!($cont -match $regex2)) {
    Write-Host "Could not match '$regex2' in '$url2'"
    return
}
$path = $matches[1]
$filename = $matches[2]
$microsoft365BetaVersionHistoryUrl = 'https://learn.microsoft.com/en-us/officeupdates/update-history-beta-channel'
$microsoft365BetaLatestVersionRegex = 'Build ([\d.]+)'
$cont = $(Invoke-WebRequest $microsoft365BetaVersionHistoryUrl).Content
if (!($cont -match $microsoft365BetaLatestVersionRegex)) {
    Write-Host "Could not match '$microsoft365BetaLatestVersionRegex' in '$microsoft365BetaVersionHistoryUrl'"
    return
}
Write-Output "$($Matches[1]) $path $filename"
