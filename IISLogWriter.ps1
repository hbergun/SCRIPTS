############################Log Pathlernin Okunması##############################
param ([String[]] $Paths)

##DB Operation##
$instance = "BERKS"
#DESKTOP-KFT7E28\Berk
#$userId = "myUserId"
#$password = "myPassword"

$connectionString = "Data Source=BERKS;Integrated Security=SSPI;Initial Catalog=TEST;"

$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()

$command = New-Object Data.SQLClient.SQLCommand
$command.Connection = $connection
$command.CommandText = "INSERT INTO TEST.[dbo].[IISLOGS]([Date],[Time],[SourceIP],[CSMethod],[CSUriStem],[CSUriQuery],[SPort],[CSUsername],[CIP],[UserAgent],[CSHost],[SCStatus],[SCSubStatus],[Win32Status],[SCBytes],[CSBytes],[TimeTaken]) VALUES (@Date,@Time,@SourceIP,@CSMethod,@CSUriStem,@CSUriQuery,@SPort,@CSUsername,@CIP,@UserAgent,@CSHost,@SCStatus,@SCSubStatus,@Win32Status,@SCBytes,@CSBytes,@TimeTaken)"



#.\IISLogWriter.ps1 -Paths "E:\D-Teknoloji\Powershell Script\","Other","Other"
#echo $Paths[0]
foreach ($path in $Paths){
$LogFilePathList = $(Get-ChildItem $path -Include *.log -Recurse | Select -Property Name)
Write-Host $LogFilePathList
foreach($LogFilePath in $LogFilePathList.Name){
$Logs = (Get-Content -Path $path\$LogFilePath)

for($i=1;$i -lt $Logs.Count;$i++){

if($Logs[$i].StartsWith('#')){
    Write-Host "This Line is Comment Line --> Script Passed" + $Logs[$i] 
    continue;
}
Write-Host "Everything is Fine"
$P = $Logs[$i].Split(' ')
#$query = "INSERT INTO TEST.[dbo].[IISLOGS]([Date],[Time],[SourceIP],[CSMethod],[CSUriStem],[CSUriQuery],[SPort],[CSUsername],[CIP],[UserAgent],[CSHost],[SCStatus],[SCSubStatus],[Win32Status],[SCBytes],[CSBytes],[TimeTaken]) VALUES (@Date,@Time,@SourceIP,@CSMethod,@CSUriStem,@CSUriQuery,@SPort,@CSUsername,@CIP,@UserAgent,@CSHost,@SCStatus,@SCSubStatus,@Win32Status,@SCBytes,@CSBytes,@TimeTaken)"
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@Date', [Data.SQLDBType]::Date))).Value = $P[0]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@Time', [Data.SQLDBType]::Time))).Value = $P[1]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@SourceIP', [Data.SQLDBType]::NVarChar,39))).Value = $P[2]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@CSMethod', [Data.SQLDBType]::NVarChar,7))).Value = $P[3]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@CSUriStem', [Data.SQLDBType]::NVarChar,-1))).Value = $P[4]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@CSUriQuery', [Data.SQLDBType]::NVarChar,-1))).Value = $P[5]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@SPort', [Data.SQLDBType]::Int))).Value = $P[6]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@CSUsername', [Data.SQLDBType]::NVarChar,-1))).Value = $P[7]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@CIP', [Data.SQLDBType]::NVarChar,39))).Value = $P[8]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@UserAgent', [Data.SQLDBType]::NVarChar,-1))).Value = $P[9]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@CSHost', [Data.SQLDBType]::NVarChar,-1))).Value = $P[10]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@SCStatus', [Data.SQLDBType]::SmallInt))).Value = $P[11]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@SCSubStatus', [Data.SQLDBType]::SmallInt))).Value = $P[12]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@Win32Status', [Data.SQLDBType]::SmallInt))).Value = $P[13]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@SCBytes', [Data.SQLDBType]::Int))).Value = $P[14]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@CSBytes', [Data.SQLDBType]::Int))).Value = $P[15]
$command.Parameters.Add((New-Object Data.SqlClient.SqlParameter('@TimeTaken', [Data.SQLDBType]::Int))).Value = $P[16]


$command.ExecuteNonQuery() | Out-Null
$command.Parameters.Clear()
  }
 }
}

$connection.Close()

