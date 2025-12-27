# Start Discovery Service
Write-Host "Starting Discovery Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "mvn spring-boot:run -f discovery-service/pom.xml"

# Wait for Discovery (Increased wait time)
Write-Host "Waiting 30 seconds for Discovery Service..."
Start-Sleep -Seconds 30

# Start Config Service
Write-Host "Starting Config Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "mvn spring-boot:run -f config-service/pom.xml"

# Wait for Config (Increased wait time)
Write-Host "Waiting 45 seconds for Config Service..."
Start-Sleep -Seconds 45

# Start Backend Services
Write-Host "Starting Gateway, Customer, Inventory, Billing..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "mvn spring-boot:run -f gateway-service/pom.xml"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "mvn spring-boot:run -f customer-service/pom.xml"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "mvn spring-boot:run -f inventory-service/pom.xml"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "mvn spring-boot:run -f billing-service/pom.xml"

Write-Host "Backend services starting in separate windows."
Write-Host "IMPORTANT: Check the new windows for any RED error messages."
Write-Host "If services fail, ensure you have internet access for Maven dependencies."
