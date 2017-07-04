#Configure TCP on EDGE1
New-NetIPAddress -InterfaceAlias "Corpnet" -IPAddress 10.0.0.2 -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias "Corpnet" -ServerAddresses 10.0.0.1
Set-DnsClient -InterfaceAlias "Corpnet" -ConnectionSpecificSuffix corp.contoso.com
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 131.107.0.2 -AddressFamily IPv4 -PrefixLength 24
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 131.107.0.3 -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 131.107.0.1
Set-DnsClient -InterfaceAlias "Ethernet" -ConnectionSpecificSuffix isp.example.com
New-NetFirewallRule –DisplayName “Allow ICMPv4-In” –Protocol ICMPv4
New-NetFirewallRule –DisplayName “Allow ICMPv4-Out” –Protocol ICMPv4 –Direction Outbound

#Join Domain
Add-Computer -NewName EDGE1 -DomainName corp.contoso.com
Restart-Computer