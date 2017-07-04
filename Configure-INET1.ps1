#Configure TCP on INET1
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 131.107.0.1 -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 127.0.0.1
Set-DnsClient -InterfaceAlias Ethernet -ConnectionSpecificSuffix isp.example.com 
New-NetFirewallRule –DisplayName “Allow ICMPv4-In” –Protocol ICMPv4
New-NetFirewallRule –DisplayName “Allow ICMPv4-Out” –Protocol ICMPv4 –Direction Outbound

#Rename INET1
Rename-Computer -NewName INET1
Restart-Computer

#Install DNS and IIS
Install-WindowsFeature DNS -IncludeManagementTools
Install-WindowsFeature Web-WebServer -IncludeManagementTools

#Create DNS Records
Add-DnsServerPrimaryZone -Name isp.example.com -ZoneFile isp.example.com.dns
Add-DnsServerResourceRecordA -ZoneName isp.example.com -Name inet1 -IPv4Address 131.107.0.1
Add-DnsServerPrimaryZone -Name contoso.com -ZoneFile contoso.com.dns
Add-DnsServerResourceRecordA -ZoneName contoso.com -Name edge1 -IPv4Address 131.107.0.2
Add-DnsServerPrimaryZone -Name msftncsi.com -ZoneFile msftncsi.com.dns
Add-DnsServerResourceRecordA -ZoneName msftncsi.com -Name www -IPv4Address 131.107.0.1
Add-DnsServerResourceRecordA -ZoneName msftncsi.com -Name dns -IPv4Address 131.107.255.255

#Install and configure DHCP
Install-WindowsFeature DHCP -IncludeManagementTools
Add-DhcpServerv4Scope -name "Internet" -StartRange 131.107.0.100  -EndRange 131.107.0.150 -SubnetMask 255.255.255.0
Set-DhcpServerv4OptionValue -DnsDomain isp.example.com -DnsServer 131.107.0.1 -Router 131.107.0.1

#Configure NCSI
$filename = "C:\inetpub\wwwroot\ncsi.txt"
$text = "Microsoft NCSI"
[System.IO.File]::WriteAllText($fileName, $text)