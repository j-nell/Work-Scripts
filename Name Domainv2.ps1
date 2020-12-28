<#
	This script enables the built in administrator account as well as prompts the user to rename the computer and join it to a domain.
	Created by: Janelle Cahee 3/1/2019
#>	
 
#Enable built in Administrator account
$Password =  Read-Host -AsSecureString -Prompt "Enter Administrator Credentials"
Enable-LocalUser -Name "Administrator"
Set-LocalUser -Name "Administrator" -Password $Password

#Disable local user made for setup
#$localUser = Admin
Disable-LocalUser -Name	Admin

#Rename the computer and join it to a domain
$newName = Read-Host -Prompt "Enter Computer Name"
Rename-Computer -NewName $newName -LocalCredential Administrator -Force
Add-Computer -DomainName "hartfordcsd.org" -Restart -Force