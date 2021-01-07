### Listing Computer Manufacturer and Model
Get-CimInstance -ClassName Win32_ComputerSystem

### Listing Installed Hotfixes
Get-CimInstance -ClassName Win32_QuickFixEngineering

### Listing Operating System Version Information
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property Build*,OSType,ServicePack*

### Listing Local Users and Owner
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property *user*

### Getting the User Logged on to a Computer
Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName

### Working with registry
Get-ChildItem -Path HKCU:\ -Recurse
get-psdrive # - registry tree path
cd HKCU:\ # - accessing and navigating registry 
Copy-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' -Destination HKCU:
New-Item -Path HKCU:\Software_DeleteMe
Remove-Item -Path HKCU:\Software_DeleteMe
Remove-Item -Path HKCU:\CurrentVersion\* -Recurse # -recursive to remove all under 

### Connecting a Windows Accessible Network Drive
(New-Object -ComObject WScript.Network).MapNetworkDrive('B:', '\\FPS01\users')
net use B: \\FPS01\users # same as abow but only works on Windows

### Run a script on a server
Invoke-Command -FilePath c:\scripts\test.ps1 -ComputerName Server01

### Run a command on a remote server
Invoke-Command -ComputerName Server01 -Credential Domain01\User01 -ScriptBlock { Get-Culture }

### Run a single command on several computers
$parameters = @{
    ComputerName = "Server01", "Server02", "TST-0143", "localhost"
    ConfigurationName = 'MySession.PowerShell'
    ScriptBlock = { Get-WinEvent -LogName PowerShellCore/Operational }
  }
  Invoke-Command @parameters

  ### Start scripts on many remote computers
  $parameters = @{
    ComputerName = (Get-Content -Path C:\Test\Servers.txt)
    InDisconnectedSession = $true
    FilePath = "\\Scripts\Public\ConfigInventory.ps1"
    SessionOption = @{OutputBufferingMode="Drop";IdleTimeout=43200000}
  }
  Invoke-Command @parameters

  