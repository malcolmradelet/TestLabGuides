![Server2012](Server%202012%20Logo.png)
# Test Lab Guide: Windows Server 2012 R2 Base Configuration

#### Abstract

This Microsoft Test Lab Guide (TLG) provides you with step-by-step instructions to create the Windows Base Configuration test lab, using computers running Windows 8.1 or Windows Server 2012 R2. With the resulting test lab environment, you can build test labs based on other Windows Server 2012 R2-based TLGs from Microsoft, TLG extensions in the TechNet Wiki, or a test lab of your own design that can include Microsoft or non-Microsoft products. For a test lab based on physical computers, you can image the drives for future test labs. For a test lab based on virtual machines, you can create snapshots of the base configuration virtual machines. This enables you to easily return to the base configuration test lab, where most of the routine infrastructure and networking services have already been configured, so that you can focus on building a test lab for the product, technology, or solution of interest

#### Copyright Information

This document is provided for informational purposes only and Microsoft makes no warranties, either express or implied, in this document. Information in this document, including URL and other Internet Web site references, is subject to change without notice. The entire risk of the use or the results from the use of this document remains with the user. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place, or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation. 

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

© 2013 Microsoft Corporation. All rights reserved.
Date of last update: 12/6/2013
Microsoft, Windows, Active Directory, Internet Explorer, and Windows Server are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.

All other trademarks are property of their respective owners.

#### Introduction

Test Lab Guides (TLGs) allow you to get hands-on experience with new products and technologies using a pre-defined and tested methodology that results in a working configuration. When you use a TLG to create a test lab, instructions tell you what servers to create, how to configure the operating systems and platform services, and how to install and configure any additional products or technologies. A TLG experience enables you to see all of the components and the configuration steps on both the front-end and back-end that go into a single- or multi-product or technology solution.

A challenge in creating useful TLGs is to enable their reusability and extensibility. Because creating a test lab can represent a significant investment of time and resources, your ability to reuse and extend the work required to create test labs is important. An ideal test lab environment would enable you to create a basic lab configuration, save that configuration, and then build out multiple test labs in the future by starting with that basic configuration.

The purpose of this TLG is to enable you to create the Windows Server 2012 R2 Base Configuration test lab, upon which you can build a test lab based on other Windows Server 2012 R2 -based TLGs from Microsoft, TLG extensions in the TechNet Wiki, or a test lab of your own design that can include Microsoft or non-Microsoft products.

Depending on how you deploy your test lab environment, you can image the drives for the Windows Server 2012 R2 Base Configuration test lab if you are using physical computers or you can create snapshots of the Base Configuration test lab virtual machines. This enables you to easily return to baseline configuration where most of the routine client, server, and networking services have already been configured so that you can focus on building out a test lab for the products or technologies of interest. For this reason, make sure that you perform a disk image on each computer if you’re using physical computers, or perform virtual machine snapshots if you are using virtual machines after completing all the steps in this TLG.

The Windows Server 2012 R2 Base Configuration TLG is just the beginning of the test lab experience. Other Windows Server 2012 R2-based TLGs or TLG extensions in the TechNet Wiki focus on Microsoft products or platform technologies, but all of them use this Windows Server 2012 R2 Base Configuration TLG as a starting point. 

#### In this guide
This document contains instructions for setting up the Windows Server 2012 R2 Base Configuration test lab by deploying four server computers running Windows Server 2012 R2 and one client computer running Windows 8.1. The resulting configuration simulates a private intranet and the Internet.

>Important 

The following instructions are for configuring the Windows Server 2012 R2 Base Configuration test lab. Individual computers are needed to separate the services provided on the network and to clearly show the desired functionality. This configuration is neither designed to reflect best practices nor does it reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed only to work on a separate test lab network.

>Note: 
>If you are able to work from a computer-based copy of this document during the lab exercises, and you are running virtual machines in Hyper-V, leverage the Hyper-V clipboard integration feature to paste commands. This will minimize potential errors with mistyped command strings.
* Highlight and right-click a command from this document listed in bold text.
* Click Copy.
* From the virtual machine menu bar, click Clipboard, and then click Type clipboard text.

#### Test lab overview
The Windows Server 2012 R2 Base Configuration test lab consists of the following:
* One computer running Windows Server 2012 R2 named DC1 that is configured as an intranet domain controller, Domain Name System (DNS) server, and Dynamic Host Configuration Protocol (DHCP) server.
* One intranet member server running Windows Server 2012 R2 named APP1 that is configured as a general application and web server.
* One member client computer running Windows 8.1 named CLIENT1 that will switch between Internet and intranet subnets.
* One intranet member server running Windows Server 2012 R2 named EDGE1 that is configured as an Internet edge server.
* One standalone server running Windows Server 2012 R2 named INET1 that is configured as an Internet DNS server, web server, and DHCP server.
The Windows Server 2012 R2 Base Configuration test lab consists of two subnets that simulate the following:
* The Internet, referred to as the Internet subnet (131.107.0.0/24).
* An intranet, referred to as the Corpnet subnet (10.0.0.0/24), separated from the Internet subnet by EDGE1.
Computers on each subnet connect using a physical hub, switch, or virtual switch. See the following figure for the configuration of the Windows Server 2012 R2 Base Configuration test lab.
