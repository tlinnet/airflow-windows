# Check if environments exists
$CURENV = Get-ChildItem Env:
$AENVexist = $false
$SLUGENVexist = $false

foreach ($line in $CURENV) {
    #Write-Host $line.Name
    If ($line.Name -like $AIRFLOW_HOME_KEY) { 
        #$AENVexist = $true
    }
    If ($line.Name -like $SLUGENV_KEY) { 
        #$SLUGENVexist = $true
    }
}

# Set environments
If ($SLUGENVexist) {
    $CURSLUGENV = (Get-Item Env:$SLUGENV_KEY).Value
    Write-Host "SLUGIFY environment exists: '$SLUGENV_KEY'" $CURSLUGENV
    If (!($CURSLUGENV -eq $SLUGENV_VAL)) {
        Write-Host "Current SLUGIFY environment is different from setting. $CURSLUGENV != $SLUGENV_VAL . Creating: $SLUGENV_KEY=$SLUGENV_VAL"
        #Write-Host "You might need to run this powershell as Administrator"
        [Environment]::SetEnvironmentVariable($SLUGENV_KEY, $SLUGENV_VAL, $ETYPE)
        $Env:AIRFLOW_HOME = [System.Environment]::GetEnvironmentVariable($SLUGENV_KEY, $ETYPE)
    }
}
Else {
    Write-Host "SLUGIFY environment doet not exists. Creating: $SLUGENV_KEY=$SLUGENV_VAL"
    #Write-Host "You might need to run this powershell as Administrator"
    [Environment]::SetEnvironmentVariable($SLUGENV_KEY, $SLUGENV_VAL, $ETYPE)
    $Env:AIRFLOW_HOME = [System.Environment]::GetEnvironmentVariable($SLUGENV_KEY, $ETYPE)
}
Write-Host "Env:SLUGIFY_USES_TEXT_UNIDECODE=$Env:SLUGIFY_USES_TEXT_UNIDECODE"

# Set environments
If ($AENVexist) {
    $CURAENV = (Get-Item Env:$AIRFLOW_HOME_KEY).Value
    Write-Host "Airflow environment exists: '$AIRFLOW_HOME_KEY'" $CURAENV
    If (!($CURAENV -eq $AIRFLOW_HOME_VAL)) {
        Write-Host "Current airflow environment is different from setting. $CURAENV != $AIRFLOW_HOME_VAL . Creating: $AIRFLOW_HOME_KEY=$AIRFLOW_HOME_VAL"
        #Write-Host "You might need to run this powershell as Administrator"
        [Environment]::SetEnvironmentVariable($AIRFLOW_HOME_KEY, $AIRFLOW_HOME_VAL, $ETYPE)
        $Env:AIRFLOW_HOME = [System.Environment]::GetEnvironmentVariable($AIRFLOW_HOME_KEY, $ETYPE)
        If(!(test-path $AIRFLOW_HOME_VAL)) { New-Item -ItemType Directory -Force -Path $AIRFLOW_HOME_VAL}
    }
}
Else {
    Write-Host "Airflow environment doet not exists. Creating: $AIRFLOW_HOME_KEY=$AIRFLOW_HOME_VAL"
    #Write-Host "You might need to run this powershell as Administrator"
    [Environment]::SetEnvironmentVariable($AIRFLOW_HOME_KEY, $AIRFLOW_HOME_VAL, $ETYPE)
    $Env:AIRFLOW_HOME = [System.Environment]::GetEnvironmentVariable($AIRFLOW_HOME_KEY, $ETYPE)
    If(!(test-path $AIRFLOW_HOME_VAL)) { New-Item -ItemType Directory -Force -Path $AIRFLOW_HOME_VAL}
}
Write-Host "Env:AIRFLOW_HOME=$Env:AIRFLOW_HOME"