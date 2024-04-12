# reference: https://raw.githubusercontent.com/mamba-org/micromamba-releases/main/install.ps1
# reference: https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html

# check if VERSION env variable is set, otherwise use "latest"
$VERSION = if ($null -eq $Env:VERSION) { "latest" } else { $Env:VERSION }

$RELEASE_URL="https://github.com/richinsley/installscripts/releases/$VERSION/download/comfycli-win-64"

Write-Output "Downloading comfycli from $RELEASE_URL"
curl.exe -L -o comfycli.exe $RELEASE_URL

New-Item -ItemType Directory -Force -Path  $Env:LocalAppData\comfycli | out-null

$COMFYCLI_INSTALL_PATH = Join-Path -Path $Env:LocalAppData -ChildPAth comfycli\comfycli.exe

Write-Output "`nInstalling comfycli to $Env:LocalAppData\comfycli`n"
Move-Item -Force comfycli.exe $COMFYCLI_INSTALL_PATH | out-null

# Add comfycli to PATH if the folder is not already in the PATH variable
$PATH = [Environment]::GetEnvironmentVariable("Path", "User")
if ($PATH -notlike "*$Env:LocalAppData\comfycli*") {
    Write-Output "Adding $COMFYCLI_INSTALL_PATH to PATH`n"
    [Environment]::SetEnvironmentVariable("Path", "$Env:LocalAppData\comfycli;" + [Environment]::GetEnvironmentVariable("Path", "User"), "User")
} else {
    Write-Output "$COMFYCLI_INSTALL_PATH is already in PATH`n"
}