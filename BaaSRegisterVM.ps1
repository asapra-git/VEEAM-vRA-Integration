param(
$user,
$password,
$VMName,
$JobName
)

#  Log file time stamp:
$LogTime = Get-Date -Format "MM-dd-yyyy_hh-mm-ss"
#  Log file name:
$LogFile = 'C:\Scripts\BaaS-PSLogs\'+ $VMName +"LOG_"+$LogTime+".log"

New-Item -Path $LogFile -ItemType "File" -Force

Add-PSSnapin VeeamPSSnapin

Connect-VBRServer -Server VEEAMServer_hostname -User $user -Password $password | Tee-Object -FilePath $LogFile

$FetchJob = Get-VBRJob -Name $JobName | Tee-Object -FilePath $LogFile

$FetchVM = Find-VBRViEntity -Name $VMName | Tee-Object -FilePath $LogFile

$output= Add-VBRViJobObject -Job $FetchJob -Entities $FetchVM | Tee-Object -FilePath $LogFile

return $output | Tee-Object -FilePath $LogFile

Disconnect-VBRServer