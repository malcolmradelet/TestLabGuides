#Configure TCP on App1
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 10.0.0.3 -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 10.0.0.1
New-NetFirewallRule –DisplayName “Allow ICMPv4-In” –Protocol ICMPv4
New-NetFirewallRule –DisplayName “Allow ICMPv4-Out” –Protocol ICMPv4 –Direction Outbound

#Join App1 to Domain
Add-Computer -NewName APP1 -DomainName corp.contoso.com
Restart-Computer

#Install Web Server
Install-WindowsFeature Web-WebServer -IncludeManagementTools

#Create Shared Folder
New-Item -path c:\Files -type directory
Write-Output "This is a shared file." | out-file c:\Files\example.txt
New-SmbShare -name files -path c:\Files -changeaccess CORP\User1
