
```bash
"${SHELL}" <(curl -L https://raw.githubusercontent.com/richinsley/installscripts/main/installer.sh)
```

```
Invoke-Expression ((Invoke-WebRequest -Uri https://raw.githubusercontent.com/richinsley/installscripts/main/installer.ps1).Content)
```

windows installs to:
```
C:\Users\johnn\AppData\Local\comfycli

# remove folder
Remove-Item 'C:\Users\johnn\AppData\Local\comfycli'

# remove path entry
[Environment]::SetEnvironmentVariable("Path", ([Environment]::GetEnvironmentVariable("Path", "User") -replace ";?$([regex]::Escape($Env:LocalAppData))\\comfycli;?", ""), "User"); $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")
```