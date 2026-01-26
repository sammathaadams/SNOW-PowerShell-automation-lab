# SNOW-PowerShell-Automation-Lab

## Project Overview
This project demonstrates the technical process of automating IT service management tasks through API integration. It provides a standardized procedure for programmatically creating incidents in a ServiceNow development instance using PowerShell and the Table API.

[# Watch Me complete this lab here](img width="1103" height="578" alt="snow lab thumb nail" src="https://github.com/user-attachments/assets/eb493f53-3c7c-4970-a39d-4df9124aebf8")(https://www.loom.com/share/853580b6f5aa42a1b7f13775477db347)


## Prerequisites
- **ServiceNow Instance**: Access to a development instance (e.g., [https://dev280690.service-now.com](https://dev280690.service-now.com)).
- **Account Permissions**: User account with `rest_service` or `itil` roles.
- **Environment**: Developed and tested using **PowerShell ISE** (compatible with PowerShell 5.1).

## Implementation Script
To create an incident, run the following PowerShell script. Ensure you replace the placeholder credentials with your own.

```
powershell
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

# 4. Constructing the Incident Payload
$Body = @{
    short_description = "Automated Lab Incident"
    description       = "Incident created via PowerShell automation lab."
    category          = "Software"
    subcategory       = "Application"
    impact            = "3"
    urgency           = "3"
} | ConvertTo-Json

# 5. Executing the API Call
$Response = Invoke-RestMethod -Uri "[https://dev280690.service-now.com/api/now/table/incident](https://dev280690.service-now.com/api/now/table/incident)" `
    -Method Post `
    -Headers $Headers `
    -Body $Body

# 6. Output Results for Verification
Write-Host "Incident Created Successfully!" -ForegroundColor Green
$Response.result | Format-List number, sys_id, short_description
```


## Verification Process
After execution, success is confirmed by:
1. **API Response**: Analyzing the returned JSON for a valid `sys_id` and incident `number`.
2. **UI Confirmation**: Logging into the ServiceNow instance and searching for the generated incident number.

![Incident created Sucessfully ](https://github.com/user-attachments/assets/4ec10d39-560a-4fc8-99e9-77b680f115fc)


![Tcicket showing Incident number ](https://github.com/user-attachments/assets/8533e8db-bee5-4f03-96e9-62371288730e)



## Security Considerations
* **Credential Safety**: In a production environment, avoid hardcoding passwords. Use secure methods like `Get-Credential`.
