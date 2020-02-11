$LogFilePath = 'E:\D-Teknoloji\Powershell Script\u_ex200211.log'
#$Fields = (Get-Content -Path $LogFilePath -TotalCount 4)[-1] -split ' '
$Fields = (Get-Content -Path $LogFilePath)
echo($Fields)
