#Get credentials to use with pssession
$Creds = Get-Credential

#Get list of servers to be monitored
$ServerList = Get-Content -path C:\Users\Public\Documents\Servers.txt

#Connect to the server
foreach($Server in $ServerList)
{
    Connect-PSSession -ComputerName $Server -Credential $Creds
}

