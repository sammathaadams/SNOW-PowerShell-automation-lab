# SNOW-PowerShell-Automation-Lab

## Project Overview
This project demonstrates the technical process of automating IT service management tasks through API integration. It provides a standardized procedure for programmatically creating incidents in a ServiceNow development instance using PowerShell and the Table API.

## Prerequisites
* **ServiceNow Instance**: Access to a development instance (e.g., https://dev280690.service-now.com).
* **Account Permissions**: User account with `rest_service` or `itil` roles.
* **Environment**: PowerShell 5.1 or PowerShell Core.

## Project Files
* **[Create-SNOW-Incident.ps1](./Create-SNOW-Incident.ps1)**: The main automation script used to execute the API call.

## Verification Process
After execution, success is confirmed by:
1. **API Response**: Analyzing the returned JSON for a valid `sys_id` and incident `number`.
2. **UI Confirmation**: Logging into the ServiceNow instance and searching for the generated incident number.

## Security Considerations
* **Credential Safety**: In a production environment, avoid hardcoding passwords. Use secure methods like `Get-Credential`.
