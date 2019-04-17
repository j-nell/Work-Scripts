<#
	DISM to remove Win10 Appx apps from .wim
	https://community.spiceworks.com/topic/1548590-dism-to-remove-win10-appx-apps-from-wim
#>

Mount-WindowsImage -ImagePath "c:\Win10Install\Sources\Install.wim" -Index 1 -Path "c:\Mounted_image"


#Edit your install.wim file and remove the offending Appx Packages.
$apps=@( 	
	"9E2F88E3.Twitter"
	"ClearChannelRadioDigital.iHeartRadio"
	"Flipboard.Flipboard"
	"king.com.CandyCrushSodaSaga"
	"Microsoft.3DBuilder"
	"Microsoft.BingFinance"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingWeather"
	"Microsoft.CommsPhone"
	"Microsoft.Getstarted"
	"Microsoft.Messaging"
	"Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
	"Microsoft.Office.OneNote"
	"Microsoft.Office.Sway"
	"Microsoft.People"
	"Microsoft.SkypeApp"
	"Microsoft.Windows.Phone"
	#"Microsoft.Windows.Photos"
	#"Microsoft.WindowsAlarms"
	#"Microsoft.WindowsCalculator"
	#"Microsoft.WindowsCamera"
	"Microsoft.WindowsMaps"
	"Microsoft.WindowsPhone"
	"Microsoft.WindowsSoundRecorder"
	"Microsoft.Xbox.TCUI"
	"Microsoft.XboxApp"
	"Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"
	"microsoft.windowscommunicationsapps"
	"Microsoft.MinecraftUWP"
	"ShazamEntertainmentLtd.Shazam"		
)

foreach ($app in $apps)
	{	
		Get-AppXProvisionedPackage -path c:\mounted_image | where DisplayName -EQ $app | Remove-AppxProvisionedPackage
    }

#Test if the packages were removed 	
Get-AppxProvisionedPackage -Path c:\Mounted_Image

#Dismount and save the image
Dismount-WindowsImage -Path c:\Mounted_Image -Save