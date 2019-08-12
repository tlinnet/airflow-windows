function Get-InstalledApps {Param ([parameter(Mandatory = $true)][string] $Software)
    if ([IntPtr]::Size -eq 4) {
        $regpath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    }
    else {
        $regpath = @(
            'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
            'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
        )
    }
    $GIP = Get-ItemProperty $regpath | .{process{if($_.DisplayName -and $_.UninstallString) { $_ } }} | Select DisplayName, Publisher, InstallDate, DisplayVersion, UninstallString |Sort DisplayName
    $result = [array]$result = ($GIP | where {$_.DisplayName -like $Software}).DisplayName

    If ($result -eq $null) {
        Write-Host "`n'$Software' is not found"
    }
    ElseIf ($result.Count -eq 1) {
        #Write-Host "Exist"
        return $result[0]
    }
    Else {
        $NR = $result.Count
        Write-Host "Exist NR result: $NR"
        #$result | ForEach {[PSCustomObject]$_} | Format-Table -AutoSize 
        $result | ForEach {Write-Host $_}
        Write-Host "`nReturning NO result`n"
    }
}