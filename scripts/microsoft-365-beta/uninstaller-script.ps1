Start-Process -Wait "$dir\setup.exe" -ArgumentList @('/configure', "`"$dir\uninstall-microsoft-365.xml`"")
