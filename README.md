# AzureDevOps
Deploy Web Apps, SQL Server and Storage Account

## If this is your first time using Azure PowerShell then you must 1) install the Azure module and 2) Allow PowerShell Scripts to be executed from your machine.

Please perform these tasks manually; Open Windows PowerShell and type (or Copy/Paste) the commands below.
1) Install Azure Module to the Current User.
->Install-Module -Name Az -AllowClobber -Scope CurrentUser
NuGet prompt, select Yes: "Y"
Untrusted repository prompt, select Yes to All: "A"
2) Sign the execution policy to allow PS scripts to run.
->Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Select Yes to All "A"

You must then run the Connect_to_Azure script and select "A" the first time.

## The PowerScripts are split into 6 parts.
1)Connects to Azure.           
2)Deploys a Storage Account and a Web App from a GitHub HTML repository (Azure.com>More>Resources>Code Samples>HTML Web App).     
3)Deploys a Web App from your local Machine (ZIP file located in WebApps Branch). When prompted for path do not include quotation marks.     
4)Deploys a SQL Server and create a Blank SQL database.        
5)Populates a SQL database with a relational database from a GitHub repo.        
5)Deletes the Resource Group therefore deleting all the apps, databases and storage accounts.      

You can also run the Deploy_All PowerScript which deploys a Storage Account, a Web App from a GitHub repo, and a SQL Server with a blank Database.
------  
