#Path to files
$Location = "C:\Program Files\Microsoft Configuration Manager\inboxes\auth\ddm.old\"

$i = 0

if($i -ge 1000)
{
    remove-item -path $Location -Exclude "" #Add Usersonly folder as exclusion

    $i++
}

#Adds Progress Bar
$totalTimes = 9
$p = 0

  for ($p=0;$p -lt $totalTimes; $p++) {

  $percentComplete = ($p / $totalTimes) * 100

  Write-Progress -Activity 'Cleaning Up' -Status "Deleted $p files" -PercentComplete $percentComplete

  sleep 1

}   