# Download with HTTPS
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
$ProgressPreference = 'SilentlyContinue' # Faster download with Invoke-WebRequest

# Microsoft Visual C++ Build Tools 
# https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2019
# https://stackoverflow.com/questions/40018405/cython-cannot-open-include-file-io-h-no-such-file-or-directory
If($true){
$SW = "Visual Studio Build Tools*"
$IsInstalled = Get-InstalledApps -Software $SW
Write-Host $IsInstalled

If ($IsInstalled -eq $null) {
    Write-Host "Checking setup for: '$SW'"
    $dfile = "vs_buildtools.exe"
    $url = "https://aka.ms/vs/16/release/$dfile"
    $output = "$SoftFolder\$dfile"
    If(!(test-path $output)) { 
        Write-Host "'$output' is missing. Automatic download"
        Invoke-WebRequest -Uri $url -OutFile $output
        Write-Host "Downloaded: '$output'"
    }
    Write-Host "Installing '$SW'"

    Write-Host "`n--------------------------------------- `n"
    Write-Host "Checking setup for: '$SW', the requirement for 'Microsoft Visual C++ Build Tools'"
    Write-Host "This is not installed. Please do this manually`n"
    Write-Host "In the tab 'Workloads' select 'C++ build tools'."
    Write-Host "This will be around 3-4 GB."
    Write-Host "Possible restart machine after install"

    #$ECode = (Start-Process -FilePath $output -Args '--quiet --wait --norestart --nocache --installPath "C:\BuildTools" --all --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 -remove Microsoft.VisualStudio.Component.Windows10SDK.14393 --remove Microsoft.VisualStudio.Component.Windows81SDK' -PassThru -Wait -Verb RunAs).ExitCode;
    $ECode = (Start-Process -FilePath $output -PassThru -Wait -Verb RunAs).ExitCode;
    Write-Host "ExitCode was: '$ECode' when installing '$SW'" 
}}

# "Miniconda3*"
If($true){
$SW = "Miniconda3*"
$IsInstalled = Get-InstalledApps -Software $SW
Write-Host $IsInstalled

If ($IsInstalled -eq $null) {
    Write-Host "Checking setup for: '$SW'"
    $dfile = "Miniconda3-latest-Windows-x86_64.exe"
    $url = "https://repo.anaconda.com/miniconda/$dfile"
    $output = "$SoftFolder\$dfile"
    If(!(test-path $output)) { 
        Write-Host "'$output' is missing. Automatic download"
        Invoke-WebRequest -Uri $url -OutFile $output
        Write-Host "Downloaded: '$output'"
    }
    Write-Host "Installing '$SW'" 
    $ECode = (Start-Process -FilePath $output -Args '/InstallationType=AllUsers /RegisterPython=0 /S /D=%UserProfile%\Miniconda3' -PassThru -Wait -Verb RunAs).ExitCode;
    Write-Host "ExitCode was: '$ECode' when installing '$SW'" 
}
. 'C:\ProgramData\Miniconda3\shell\condabin\conda-hook.ps1'
conda activate 'C:\ProgramData\Miniconda3'
conda -V
}

# Erlang/OTP 22.0 : RabbitMQ requires a 64-bit supported version of Erlang
If($false){
$SW = "Erlang*"
$IsInstalled = Get-InstalledApps -Software $SW
Write-Host $IsInstalled

If ($IsInstalled -eq $null) {
    Write-Host "Checking setup for: '$SW'"
    $dfile = "otp_win64_22.0.exe"
    $url = "http://erlang.org/download/$dfile"
    $output = "$SoftFolder\$dfile"
    If(!(test-path $output)) { 
        Write-Host "'$output' is missing. Automatic download"
        Invoke-WebRequest -Uri $url -OutFile $output
        Write-Host "Downloaded: '$output'"
    }
    Write-Host "Installing '$SW'" 
    $ECode = (Start-Process -FilePath $output -Args '/S' -PassThru -Wait -Verb RunAs).ExitCode;
    Write-Host "ExitCode was: '$ECode' when installing '$SW'" 
}}

# RabbitMQ
If($false){
$SW = "RabbitMQ*"
$IsInstalled = Get-InstalledApps -Software $SW
Write-Host $IsInstalled

If ($IsInstalled -eq $null) {
    Write-Host "Checking setup for: '$SW'"
    $dfile = "rabbitmq-server-3.7.17.exe"
    $url = "https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.17/$dfile"
    $output = "$SoftFolder\$dfile"
    If(!(test-path $output)) { 
        Write-Host "'$output' is missing. Automatic download"
        Invoke-WebRequest -Uri $url -OutFile $output
        Write-Host "Downloaded: '$output'"
    }
    Write-Host "Installing '$SW'" 
    $ECode = (Start-Process -FilePath $output -Args '/S' -PassThru -Wait -Verb RunAs).ExitCode;
    Write-Host "ExitCode was: '$ECode' when installing '$SW'" 
}}