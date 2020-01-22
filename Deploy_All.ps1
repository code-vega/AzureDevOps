#Define the resource group name and location.
$resourceGroup = "test-resource-group"
$location = "eastus"

#Create new resource group.
New-AzResourceGroup -Name $resourceGroup -Location $location

#Create a new storage account.
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name storeaccnum1 -Location $location `
-SkuName Standard_LRS -Kind StorageV2

#Define the Web App and Service Plan names.
$webappname="VegaTestWebApp1"    
$AppServicePlan="TestWebApps"  

#Create an App Service plan in Free tier.  
New-AzAppServicePlan -Name $AppServicePlan -Location $location -ResourceGroupName $resourceGroup -Tier Free
 
#Create a Web App
New-AzWebApp -Name $webappname -Location $location -AppServicePlan $AppServicePlan -ResourceGroupName $resourceGroup

#Configure GitHub deployment from the GitHub repository.
$gitrepo = "https://github.com/Azure-Samples/app-service-web-html-get-started.git"
$PropertiesObject = @{
repoUrl = "$gitrepo";
branch = "master";
isManualIntegration = "true";
}

#Set the Web App resource path to the GitHub repo (Acquired from Azure.com>more>resources>sample code>html web app sample).
Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $resourceGroup `
-ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $WebAppName/web -ApiVersion 2015-08-01 -Force


#Define the new Web App, Service Plan names and app's local path.
$webappname="VegaTestWebApp2"    
$AppServicePlan="TestWebApps"
$appPath = Read-Host -Prompt "Enter the local path for the VegaWebApp2 zip file"

#Create a Web App
New-AzWebApp -Name $webappname -Location $location -AppServicePlan $AppServicePlan -ResourceGroupName $resourceGroup

#Publish Web App
Publish-AzWebApp -ResourceGroupName $resourceGroup -Name $webappname `
-ArchivePath $appPath

#SQL Database Parameters
$adminSqlLogin = "SqlAdmin"	#Server user
$password = "Password123"	#Server password
$serverName = "server-forvegatestdata"	#Server name
$databaseName = "myTestDatabase"	#Database name

#Create Server
New-AzSqlServer -ResourceGroupName $resourceGroup -ServerName $serverName -Location $location `
-SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin,`
$(ConvertTo-SecureString -String $password -AsPlainText -Force))

#Create a Firewall to allow access from any Azure IPs, Can also be set to specific IP range.
New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroup -ServerName $serverName -FirewallRuleName "Rule01" `
-StartIpAddress "0.0.0.0" -EndIpAddress "255.255.255.0"

#Create a Blank Database
New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -DatabaseName $databaseName `
-RequestedServiceObjectiveName "S0"

################# Load Data From an External Database file ###############
#parameters
$containerName = "bacpacfile"
$bacpacFileName = "BookingInfo.bacpac"
$bacpacUrl = "https://github.com/code-vega/AzureDevOps/raw/Database/BookingInfo.bacpac"
$storageAccount = (Get-AzStorageAccount -ResourceGroupName $resourceGroup)

#Download the bacpac file
Invoke-WebRequest -Uri $bacpacUrl -OutFile "$HOME/$bacpacFileName"

#Create Container and Upload the bacpac file to it
New-AzStorageContainer -Name $containerName -Context $storageAccount.Context
Set-AzStorageBlobContent -File $HOME/$bacpacFileName -Container $containerName -Blob $bacpacFileName `
-Context $storageAccount.Context

#Import a Database from a BACPAC file
New-AzSqlDatabaseImport -ResourceGroupName $resourceGroup -ServerName $serverName -DatabaseName $databaseName `
-StorageKeyType "StorageAccessKey" `
-Edition "Standard" -ServiceObjectiveName "P6" -DatabaseMaxSizeBytes "4500000" `
-StorageKey (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageName).Value[0] `
-StorageUri "https://$storageName.blob.core.windows.net/$containerName/$bacpacFileName" `
-AdministratorLogin $adminSqlLogin `
-AdministratorLoginPassword $(ConvertTo-SecureString -String $password -AsPlainText -Force)