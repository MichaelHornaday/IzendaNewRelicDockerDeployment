Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
 {
    param([string]$zipfile, [string]$outpath)
   [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
 }
 Unzip "C:\\newrelic-agent-win-8.5.186.0-scriptable-installer.zip" "C:\\newrelic-agent-win-8.5.186.0-scriptable-installer"

Set-Location C:/newrelic-agent-win-8.5.186.0-scriptable-installer/
./install.cmd -LicenseKey INSERT_LICENSE_KEY_HERE