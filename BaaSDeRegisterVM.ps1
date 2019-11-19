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

$output= Get-VBRJob -Name $JobName | Get-VBRJobObject -Name $VMName | Remove-VBRJobObject -Completely

return $output