# AzureDevOps
Deploy Web Apps, SQL Server and Storage Account
-------------------------------------------------------------------------------------------------------------------------

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

## The PowerScripts are split into 5 parts.
1)Connect to Azure.           
2)Deploy a Storage Account and a Web App from a GitHub HTML repository.     
3)Deploy a Web App from your local Machine (ZIP file located in WebApps Branch). When prompted for path do not include quotation marks. 
4)Deploy a Blank SQL Server and populate it with a relational database from a GitHub repo.        
5)Delete the Resource Group therefore deleting all the apps, databases and storage accounts.      

You can also run the Deploy_All PowerScript which combines 2 through 4.
  - You will be prompted to type the local path of the second app.
  
