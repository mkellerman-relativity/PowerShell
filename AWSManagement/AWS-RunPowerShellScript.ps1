
Import-Module -Name AWSPowerShell.NetCore
Set-AWSCredentials –AccessKey $env:ACCESSKEY –SecretKey $env:SECRETKEY

Set-DefaultAWSRegion -Region us-west-2 

# Lookup all EC2 Instances that have ends with -rdp
$Instances = (Get-EC2Instance).Instances | Where-Object { $_.Tags | Where-Object { ($_.Key -eq 'Name') -and ($_.Value -Like '*-rdp')} }

$SSMCommand = Send-SSMCommand `
    -InstanceIds $Instances.InstanceId `
    -DocumentName "AWS-RunPowerShellScript" `
    -Comment "AWS-RunPowerShellScript Example" `
    -Parameter @{'commands'=@('dir C:\Users', 'dir C:\')}
