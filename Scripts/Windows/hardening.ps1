#This is a script! Make sure to change the passwords!

Set-SmbServerConfiguration-EnableSMB1Protocol $false

Disable-WindowsOptionalFeature -Online -FeatureName “SMB1Protocol”

netsh advfirewall set allprofiles state on

Rename-LocalUser -Name "Administrator" -NewName "sysadm01"
Set-LocalUser -Name "sysadm01" -Password (Read-Host -AsSecureString "New password")
Disable-LocalUser -Name "Guest"

$pw = Read-Host -AsSecureString "Password"
New-LocalUser -Name "backupadmin" -Password $pw
Add-LocalGroupMember -Group "Administrators" -Member "backupadmin"


# Disable RDP entirely if it's not needed
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal 
Server' -Name "fDenyTSConnections" -Value 

# If RDP is needed, require Network Level Authentication
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Get-NetFirewallRule -Enabled True | Format-Table DisplayName,Direction,Action

# OpenSSH server: edit C:\ProgramData\ssh\sshd_config
#   PermitRootLogin no
#   PasswordAuthentication no
Restart-Service sshd

auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /get /category:*

gpupdate /force

# Turn on PowerShell Script Block Logging
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging' -Name "EnableScriptBlockLogging" -Value 1



# Install Sysmon with a config file
.\Sysmon64.exe -accepteula -i config.xml
sysmon.exe -accepteula -i sysmonconfig-export.xml