################# Load Data From an External Database file ###############

#Define the resource group name and location.
$resourceGroup = "test-resource-group"
$location = "eastus"
$storageName = "storeaccnum1"

#SQL Database Parameters
$adminSqlLogin = "SqlAdmin"	#Server user
$password = "Password123"	#Server password
$serverName = "server-forvegatestdata"	#Server name
$databaseName = "myTestDatabase"	#Database name

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
