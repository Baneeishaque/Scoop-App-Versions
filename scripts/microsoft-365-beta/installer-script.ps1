Start-Process -Wait 7z1900-helper -ArgumentList @('x', '-bso0', "`"$dir\dl.7z_`"", "`"-o$dir`"")
Start-Process -Wait "$dir\setup.exe" -ArgumentList @('/configure', "`"$dir\install-$app.xml`"")
