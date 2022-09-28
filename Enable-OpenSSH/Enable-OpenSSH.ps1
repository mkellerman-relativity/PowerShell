Add-WindowsCapability -Online -Name OpenSSH.Server
Add-WindowsCapability -Online -Name OpenSSH.Client

netsh advfirewall firewall add rule name="SSH" dir=in localport=22 protocol=TCP action=allow

"PasswordAuthentication yes" |Add-Content $env:ProgramData\ssh\sshd_config
Set-Service sshd -StartupType Automatic
Restart-Service sshd
