param (
	[string]$SW = ""
)

# Settings
#$AIRFLOW_VERSION = "latest" # version or 'latest'
#$AIRFLOW_VERSION = "1.10.4" # version or 'latest'
$AIRFLOW_VERSION = "1.10.4" # version or 'latest'
$CLEAN = $true # Remove current conda environment and install, delete unzipped sourcefolder

# Init
$ErrorActionPreference = "Stop"
#Remove-Module Get-InstalledApps
Import-Module .\ps_modules\Get-InstalledApps.psm1

# Environments
$ETYPE="User" # Machine
$AIRFLOW_HOME_KEY = "AIRFLOW_HOME"
$AIRFLOW_HOME_VAL = "$PSScriptRoot\airflow_home" #"~/airflow"
$SLUGENV_KEY = "SLUGIFY_USES_TEXT_UNIDECODE" # Necessary before: Airflow 1.10.3 https://github.com/apache/airflow/blob/master/UPDATING.md
$SLUGENV_VAL = "yes"
. .\ps_modules\Set-Environments.ps1


# Download software and install
$SoftFolder = "$PSScriptRoot\bin"
If(!(test-path $SoftFolder)) { New-Item -ItemType Directory -Force -Path $SoftFolder}
. .\ps_modules\Install-Software.ps1

# Create Python environment
$CondaENV = "airflow"

$clist = conda env list
$cexist = $false
foreach ($line in $clist) {
    Write-Host $line
    If ($line -like "*$CondaENV*") { 
        $cexist = $true
    }
}
If ($cexist) {
    If($CLEAN = $true){
        Write-Host "conda environment exists: reinstalling'$CondaENV'"
        & conda remove --name $CondaENV --all --yes
        & conda env create -f environment.yml
    }
    Else{
        Write-Host "conda environment exists. Updating: '$CondaENV'"
        & conda env update -f environment.yml
    }
}
Else {
    Write-Host "conda environment doet not exists. Creating: '$CondaENV'"
    & conda env create -f environment.yml
}
Write-Host "Activating $CondaENV"
conda activate $CondaENV

# Manual build aiflow
If($AIRFLOW_VERSION -eq "latest"){
    $latestRelease = Invoke-WebRequest "https://github.com/apache/airflow/releases/latest" -Headers @{"Accept"="application/json"}
    $json = $latestRelease.Content | ConvertFrom-Json
    $AIRFLOW_VERSION_SEL = $json.tag_name
}
Else{
    $AIRFLOW_VERSION_SEL = $AIRFLOW_VERSION
}
#Write-Host "$AIRFLOW_VERSION = $AIRFLOW_VERSION_SEL"

$dfile = "$AIRFLOW_VERSION_SEL.zip"
$url = "https://github.com/apache/airflow/archive/$dfile"
$output = "$SoftFolder\$dfile"
If(!(test-path $output)) { 
    Write-Host "'$output' is missing. Automatic download"
    Invoke-WebRequest -Uri $url -OutFile $output
    Write-Host "Downloaded: '$output'"
}

$AIRFLOWSOURCE = "airflow-$AIRFLOW_VERSION_SEL"
If(!(test-path $AIRFLOWSOURCE)) { 
    Expand-Archive $output -DestinationPath "$PSScriptRoot"
}
Else {
    If($CLEAN = $true){
        Remove-Item -LiteralPath $AIRFLOWSOURCE -Force -Recurse
        Expand-Archive $output -DestinationPath "$PSScriptRoot"
    }
}

Set-Location $AIRFLOWSOURCE
If($AIRFLOW_VERSION_SEL -eq "1.10.3"){
    (Get-Content "setup.py") | where { $_ -ne "            'werkzeug>=0.14.1, <0.15.0'," } | Set-Content "setup.py"
    (Get-Content "setup.py") -replace "'jinja2>=2.7.3, <=2.10.0',", "'jinja2>=2.10.1, <2.11.0'," | Set-Content "setup.py"
    (Get-Content "setup.py") -replace "'tzlocal>=1.4',", "'tzlocal>=1.4, <2.0'," | Set-Content "setup.py"
}
ElseIf ($AIRFLOW_VERSION_SEL -eq "1.10.4") {
    (Get-Content "setup.py") | where { $_ -ne "            'dumb-init>=1.2.2'," } | Set-Content "setup.py"
    
}

pip install .
$AIRFLOW_SCRIPT = (where.exe airflow)
python $AIRFLOW_SCRIPT