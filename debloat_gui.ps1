# Ensure the script runs with Administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run this script as an Administrator!"
    Exit
}

# Load the native Windows Forms graphical engine
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the main Application Window
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Custom Windows Debloater Utility"
$Form.Size = New-Object System.Drawing.Size(450, 500)
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Title Label Instruction Text
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Select components to clean or disable:"
$Label.Location = New-Object System.Drawing.Point(20, 20)
$Label.Size = New-Object System.Drawing.Size(400, 20)
$Form.Controls.Add($Label)

# Dictionary map containing display names linked to system package strings
$Apps = [ordered]@{
    "Remove Bing News & Weather"  = "Microsoft.Bing"
    "Remove 3D Builder & Skype"   = "3DBuilder|Skype"
    "Remove Solitaire Collection" = "SolitaireCollection"
    "Remove Your Phone Sync"      = "YourPhone"
    "Remove Get Help & Tips"      = "GetHelp|Getstarted"
}

# Create Checkboxes programmatically in a vertical stack
$Checkboxes = @{}
$YCoord = 50

foreach ($DisplayName in $Apps.Keys) {
    $CheckBox = New-Object System.Windows.Forms.CheckBox
    $CheckBox.Text = $DisplayName
    $CheckBox.Location = New-Object System.Drawing.Point(30, $YCoord)
    $CheckBox.Size = New-Object System.Drawing.Size(350, 25)
    $Form.Controls.Add($CheckBox)
    $Checkboxes[$DisplayName] = $CheckBox
    $YCoord += 30
}

# Group System Performance Toggles
$TelemetryCheck = New-Object System.Windows.Forms.CheckBox
$TelemetryCheck.Text = "Disable Telemetry Data Tracking & DiagTrack"
$TelemetryCheck.Location = New-Object System.Drawing.Point(30, $YCoord + 10)
$TelemetryCheck.Size = New-Object System.Drawing.Size(350, 25)
$Form.Controls.Add($TelemetryCheck)

# Execution Action Button
$RunButton = New-Object System.Windows.Forms.Button
$RunButton.Text = "Execute Selected Tasks"
$RunButton.Location = New-Object System.Drawing.Point(30, $YCoord + 60)
$RunButton.Size = New-Object System.Drawing.Size(370, 40)
$RunButton.BackColor = [System.Drawing.Color]::LightGreen
$Form.Controls.Add($RunButton)

# Output Console Log Box inside the window
$LogBox = New-Object System.Windows.Forms.TextBox
$LogBox.Multiline = $true
$LogBox.ScrollBars = "Vertical"
$LogBox.Location = New-Object System.Drawing.Point(30, $YCoord + 120)
$LogBox.Size = New-Object System.Drawing.Size(370, 100)
$LogBox.ReadOnly = $true
$Form.Controls.Add($LogBox)

# Function to write notes into the GUI window text box log
function Log-Write($Text) {
    $LogBox.AppendText("$Text`r`n")
}

# Logic Engine: Action triggered when the user clicks the button
$RunButton.Add_Click({
    $RunButton.Enabled = $false
    Log-Write "Initializing debloat routine..."
    
    # Process Application Checkboxes
    foreach ($DisplayName in $Apps.Keys) {
        if ($Checkboxes[$DisplayName].Checked) {
            $TargetKeyword = $Apps[$DisplayName]
            Log-Write "Processing removal for target: $TargetKeyword"
            
            # Find and remove app packages matching keywords
            Get-AppxPackage -AllUsers | Where-Object {$_.Name -match $TargetKeyword} | Remove-AppxPackage -ErrorAction SilentlyContinue
            Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -match $TargetKeyword} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        }
    }
    
    # Process Telemetry Toggles
    if ($TelemetryCheck.Checked) {
        Log-Write "Stopping DiagTrack background data collection..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -ErrorAction SilentlyContinue
        Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
    }
    
    Log-Write "Execution finished! Please reboot your computer."
    [System.Windows.Forms.MessageBox]::Show("Finished executing selected tasks!", "Success", "OK", "Information")
    $RunButton.Enabled = $true
})

# Display the GUI Window Form
$Form.ShowDialog() | Out-Null
