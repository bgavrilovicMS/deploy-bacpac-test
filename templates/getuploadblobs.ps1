param(
    [parameter(Mandatory=$true)]
    [string]$RGName
)

try
  { 
  	Enable-AzureRmAlias -Scope CurrentUser
    Install-Module Az.Storage -AllowClobber -Force
    Install-Module Az.Accounts -AllowClobber - Force
    Import-Module Az.Storage
    Import-Module Az.Accounts
  }
catch
  {
    Write-Output "Skip install"
  }
Invoke-WebRequest 'https://github.com/bgavrilovicMS/deploy-bacpac-test/raw/main/data/dogwooddojo.bacpac' -OutFile dogwooddojo.bacpac
Invoke-WebRequest 'https://github.com/bgavrilovicMS/deploy-bacpac-test/raw/main/data/contosoconcerthall.bacpac' -OutFile contosoconcerthall.bacpac
Invoke-WebRequest 'https://github.com/bgavrilovicMS/deploy-bacpac-test/raw/main/data/fabrikamjazzclub.bacpac' -OutFile fabrikamjazzclub.bacpac
Invoke-WebRequest 'https://github.com/bgavrilovicMS/deploy-bacpac-test/raw/main/data/wingtiptenantdb.bacpac' -OutFile wingtiptenantdb.bacpac
Invoke-WebRequest 'https://github.com/bgavrilovicMS/deploy-bacpac-test/raw/main/data/wingtipcatalogdb.bacpac' -OutFile wingtipcatalogdb.bacpac



$StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $RGName -Name wingtipdemo
$Context = $StorageAccount.Context

Set-AzureStorageBlobContent `
-File dogwooddojo.bacpac `
-Container wingtipdemo -Blob dogwooddojo.bacpac -Context $Context -Force
Set-AzureStorageBlobContent `
-File contosoconcerthall.bacpac `
-Container wingtipdemo -Blob contosoconcerthall.bacpac -Context $Context -Force
Set-AzureStorageBlobContent `
-File fabrikamjazzclub.bacpac `
-Container wingtipdemo -Blob fabrikamjazzclub.bacpac -Context $Context -Force
Set-AzureStorageBlobContent `
-File wingtipcatalogdb.bacpac `
-Container wingtipdemo -Blob wingtipcatalogdb.bacpac -Context $Context -Force
Set-AzureStorageBlobContent `
-File wingtiptenantdb.bacpac `
-Container wingtipdemo -Blob wingtiptenantdb.bacpac -Context $Context -Force