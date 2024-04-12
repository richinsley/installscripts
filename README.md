
```bash
"${SHELL}" <(curl -L https://raw.githubusercontent.com/richinsley/installscripts/main/installer.sh)
```

```
Invoke-Expression ((Invoke-WebRequest -Uri https://raw.githubusercontent.com/richinsley/installscripts/main/installer.ps1).Content)
```

installs to
```
C:\Users\johnn\AppData\Local\comfycli

Remove-Item 'C:\Users\johnn\AppData\Local\comfycli'
```