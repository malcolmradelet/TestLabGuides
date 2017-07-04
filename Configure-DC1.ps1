#Configure TCP on DC1
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 10.0.0.1 -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 127.0.0.1
New-NetFirewallRule –DisplayName “Allow ICMPv4-In” –Protocol ICMPv4
New-NetFirewallRule –DisplayName “Allow ICMPv4-Out” –Protocol ICMPv4 –Direction Outbound

#Install ADDS
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName corp.contoso.com

#Install DHCP
Install-WindowsFeature DHCP -IncludeManagementTools
Netsh DHCP Add SecurityGroups
Restart-Service DhcpServer
Add-DhcpServerInDC -DnsName dc1.corp.contoso.com
Add-DhcpServerv4Scope -name "Corpnet" -StartRange 10.0.0.100 -EndRange 10.0.0.200 -SubnetMask 255.255.255.0
Set-DhcpServerv4OptionValue -DnsDomain corp.contoso.com -DnsServer 10.0.0.1

#Create User Account
New-ADUser -SamAccountName User1 -AccountPassword (read-host "Set user password" -assecurestring) -name "User1" -enabled $true -PasswordNeverExpires $true -ChangePasswordAtLogon $false 
Add-ADPrincipalGroupMembership -Identity "CN=User1,CN=Users,DC=corp,DC=contoso,DC=com" -MemberOf "CN=Enterprise Admins,CN=Users,DC=corp,DC=contoso,DC=com","CN=Domain Admins,CN=Users,DC=corp,DC=contoso,DC=com"