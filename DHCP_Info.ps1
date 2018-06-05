Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "DHCP Scope Information"
$form.Size = New-Object System.Drawing.Size(300,200) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(280,30) 
$label.Text = "Please enter the name of the DC you want scop information from:"
$form.Controls.Add($label) 

$textBox = New-Object System.Windows.Forms.TextBox 
$textBox.Location = New-Object System.Drawing.Point(10,50) 
$textBox.Size = New-Object System.Drawing.Size(260,20) 
$form.Controls.Add($textBox) 

$form.Topmost = $True

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
    $x
}

$computername = $x

$scopes = Get-DHCPServerv4Scope -ComputerName $computername |
Select-Object "Name","SubnetMask","StartRange","EndRange","ScopeID"

$lines = @()

$serveroptions = Get-DHCPServerv4OptionValue -ComputerName $computername -All | 
Select-Object Name,Value,VendorClass,UserClass

ForEach ($scope in $scopes) {

    ForEach ($option in $serveroptions) {

        $lines += $scope | Select-Object *,@{
            "Name"="OptionScope"
            "Expression"={ "Server" }},@{
            "Name"="OptionName"
            "Expression"={ $option.name }},@{
            "Name"="OptionValue"
            "Expression"={ $option.Value }},@{
            "Name"="OptionVendorClass"
            "Expression"={ $option.VendorClass }},@{
            "Name"="OptionUserClass"
            "Expression"={ $option.UserClass }}

    }

    $scopeoptions = Get-DhcpServerv4OptionValue -ComputerName $computername -ScopeId "$($scope.ScopeId)" -All | 
    Select-Object Name,Value,VendorClass,UserClass

    ForEach ($option in $scopeoptions) {

        $lines += $scope | Select-Object *,@{
            "Name"="OptionScope"
            "Expression"={ "Scope" }},@{
            "Name"="OptionName"
            "Expression"={ $option.name }},@{
            "Name"="OptionValue"
            "Expression"={ $option.Value }},@{
            "Name"="OptionVendorClass"
            "Expression"={ $option.VendorClass }},@{
            "Name"="OptionUserClass"
            "Expression"={ $option.UserClass }}

    }
<#	$lease = Get-DhcpServerv4OptionValue -ComputerName $computername -ScopeId "$($scope.ScopeId)" -All | 
    Select-Object "ScopeID","Free","InUse","PercentageInUse","Reserved","Pending"

	ForEach ($lease in $scopes) {
		$lines += $scope | Select-Object *,@{
            "Name"="OptionScope"
            "Expression"={ "Scope" }},@{
            "Name"="OptionName"
            "Expression"={ $option.name }},@{
            "Name"="OptionValue"
            "Expression"={ $option.Value }},@{
            "Name"="OptionVendorClass"
            "Expression"={ $option.VendorClass }},@{
            "Name"="OptionUserClass"
            "Expression"={ $option.UserClass }}
	}
#>
}
$lines | Export-Csv -Path C:\Users\ajcahee\desktop\info.csv -NoTypeInformation
