#Get Txt file of usernames to search foreach
$UserList = Get-Content C:\Users\jcahee\Desktop\Book1.txt

#$FilePath = "C:\Users\jcahee\Desktop\Paths.txt"

$path = "\\data\StudentHome\Current\Washington"


Foreach($User in $UserList)
{
	#Get the path based on username
	get-childitem -path $path -Recurse -Directory -filter $folderName |
	
	#Put each path in an array
	foreach{
		$PathArray = $_.FullName
		#Output path to screen
        # $PathArray += $_.FullName
		write-host $PathArray
	}
}

#$FolderPath | out-file $FilePath
