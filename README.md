# SNOW-PowerShell-Automation-Lab

## Project Overview
This project demonstrates the technical process of automating IT service management tasks through API integration. Specifically, it provides a standardized procedure for programmatically creating incidents in a ServiceNow development instance using PowerShell and the Table API.

This lab focuses on the practical application of:
* **REST API Integration**: Interacting with the ServiceNow Table API.
* **PowerShell Scripting**: Automating HTTP requests and data handling.
* **Data Serialization**: Constructing and sending JSON payloads.

## Prerequisites
To replicate this lab, the following are required:
* **ServiceNow Instance**: Access to a development instance (e.g., https://dev280690.service-now.com).
* **Account Permissions**: A user account with `rest_service` or `itil` roles.
* **Environment**: A terminal with PowerShell 5.1 or PowerShell Core.

## Implementation Script
The following PowerShell script is used to execute the automated incident creation. It has been updated to point directly to the `/api/now/table/incident` pathway.

# 1. Credentials Configuration
$User = "YOUR_USERNAME"
$Pass = "YOUR_PASSWORD"

# 2. Base64 Encoding for Basic Authentication
$pair = "${User}:${Pass}"
$bytes = [System.Text.Encoding]::UTF8.GetBytes($pair)
$encoded = [Convert]::ToBase64String($bytes)

# 3. Request Headers
$Headers = @{
    "Accept"        = "application/json"
    "Content-Type"  = "application/json"
    "Authorization" = "Basic $encoded"
}

# 4. Constructing the Incident Payload (JSON)
$Body = @{
    short_description = "Automated Lab Incident"
    description       = "Incident created via PowerShell automation lab."
    category          = "Software"
    subcategory       = "Application"
    impact            = "3"
    urgency           = "3"
} | ConvertTo-Json

# 5. Executing the API Call
$Response = Invoke-RestMethod -Uri "https://dev280690.service-now.com/api/now/table/incident" `
    -Method Post `
    -Headers $Headers `
    -Body $Body

# 6. Output Results for Verification
Write-Host "Incident Created Successfully!" -ForegroundColor Green
$Response.result | Format-List number, sys_id, short_description


## Verification Process
After execution, success is confirmed by:
1.  **API Response**: Analyzing the returned JSON for a valid `sys_id` and incident `number`.
2.  **UI Confirmation**: Logging into the ServiceNow instance and searching for the generated incident number.

## Security Considerations
* **Credential Safety**: In a production environment, avoid hardcoding passwords. Use secure methods like `Get-Credential`.
* **Least Privilege**: Ensure the service account only has the specific permissions required for incident creation.
