
#Define the resource group name and location.
$resourceGroup = "test-resource-group"
$location = "eastus"

#Define the new Web App, Service Plan names and app's local path.
$webappname="VegaTestWebApp2"    
$AppServicePlan="TestWebApps"
$appPath = Read-Host -Prompt "Enter the local path for the VegaWebApp2 zip file"

#Create a Web App
New-AzWebApp -Name $webappname -Location $location -AppServicePlan $AppServicePlan -ResourceGroupName $resourceGroup

#Publish Web App
Publish-AzWebApp -ResourceGroupName $resourceGroup -Name $webappname `
-ArchivePath $appPath