# Credentials Configuration
$User = "YOUR_USERNAME"
$Pass = "YOUR_PASSWORD"

# Base64 Encoding for Basic Authentication
$pair = "${User}:${Pass}"
$bytes = [System.Text.Encoding]::UTF8.GetBytes($pair)
$encoded = [Convert]::ToBase64String($bytes)

# Request Headers
$Headers = @{
    "Accept"        = "application/json"
    "Content-Type"  = "application/json"
    "Authorization" = "Basic $encoded"
}

# Constructing the Incident Payload
$Body = @{
    short_description = "Automated Lab Incident"
    description       = "Incident created via PowerShell automation lab."
    category          = "Software"
    subcategory       = "Application"
    impact            = "3"
    urgency           = "3"
} | ConvertTo-Json

# Executing the API Call
$Response = Invoke-RestMethod -Uri "https://dev280690.service-now.com/api/now/table/incident" `
    -Method Post `
    -Headers $Headers `
    -Body $Body

# Output Results for Verification
Write-Host "Incident Created Successfully!" -ForegroundColor Green
$Response.result | Format-List number, sys_id, short_description
