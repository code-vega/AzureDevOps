#Clean up deployment
$resourceGroup = "test-resource-group"
Remove-AzResourceGroup -Name $resourceGroup -Force