#Define the resource group name and location.
$resourceGroup = "test-resource-group"
$location = "eastus"
$storageName = "storeaccnum1"

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


