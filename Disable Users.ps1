# This script will disable and move Active Directory User Accounts
# A list of usernames must be provided to the script as a plain text file
# An AD OU must also be created to be the target when your want the user accounts moved to
# Created by Jason Pearce, 2016 February
 
# ####################
# BEGIN Variables
# ####################
 
# Path to a .txt file containing a list of usernames you wish to disable
$FileListOfUsers = "C:\Users\jcahee\Desktop\toDisable.txt"
 
# Active Directory OU (unique name) that users will move to
$MoveToOU = "Disabled Users"
 
# Logs Path: The path to write logs
$LogPath = "C:\Users\jcahee\Desktop"
 
# ####################
# END Variables
# ####################
 
# Import Module: Import the Powershell Active Directory module
Import-Module ActiveDirectory
 
# TimeStamp: Create a timestamp for use as part of a directory or file name
$TimeStampBefore = Get-Date -Format s | foreach {$_ -replace ":", "-"}
 
# Log Folder: Create a log folder IF it does not already exist
IF ( -Not (Test-Path -Path $LogPath)) {New-Item -Path $LogPath -ItemType Directory}
 
# Load Users: Load list of users into a variable
$ListOfUsers = Get-Content $FileListOfUsers
 
# Document Before: Document user settings before making changes
$CsvBeforePath = $LogPath+'\DisableUsers-'+$MoveToOU+'-'+$TimeStampBefore+'-before.csv'
$ListOfUsers | Get-ADUser | Export-Csv -Path $CsvBeforePath
 
# Disable Users: Disable these Active Directory user accounts (remove -WhatIf)
$ListOfUsers | Get-ADUser | Disable-ADAccount -WhatIf
 
# Pause: Pause 30 seconds for Active Directory to replicate changes
Start-Sleep -s 30
 
# Move Users: Move these Active Directory user accounts (remove -WhatIf)
$ListOfUsers | Get-ADUser | Move-ADObject -TargetPath (Get-ADOrganizationalUnit -Filter 'Name -eq $MoveToOU') -WhatIf
 
# Pause: Pause 30 seconds for Active Directory to replicate changes
Start-Sleep -s 30
 
# TimeStamp: Create a timestamp for use as part of a directory or file name
$TimeStampAfter = Get-Date -Format s | foreach {$_ -replace ":", "-"}
 
# Document users after making changes
$CsvAfterPath = $LogPath+'\DisableUsers-'+$MoveToOU+'-'+$TimeStampAfter+'-after.csv'
$ListOfUsers | Get-ADUser | Export-Csv -Path $CsvAfterPath