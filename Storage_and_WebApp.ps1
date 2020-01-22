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
