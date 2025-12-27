# Run All Services (Backend + Frontend)
# This script launches all necessary microservices and the Angular frontend.

$JavaHome = "C:\Program Files\Java\jdk-17"
$env:JAVA_HOME = $JavaHome
$env:Path = "$JavaHome\bin;" + $env:Path

Write-Host "Starting Ecom App - All Services" -ForegroundColor Green

# Cleanup: Kill key processes to free up ports (Frontend)
Write-Host "Cleaning up old Node.js processes..." -ForegroundColor Gray
Stop-Process -Name "node" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "ng" -Force -ErrorAction SilentlyContinue

Function Run-Service {
    param([string]$Path, [string]$Name)
    Write-Host "Starting $Name..." -ForegroundColor Cyan
    # Use cmd /c to run maven directly, bypassing PS execution policies entirely
    Start-Process cmd -ArgumentList "/k", "cd /d $Path && mvn spring-boot:run"
}

# 1. Infrastucture
Write-Host "Phase 1: Infrastructure" -ForegroundColor Yellow
Run-Service -Path "discovery-service" -Name "Discovery Service"
Write-Host "Waiting 15s for Discovery..."
Start-Sleep -Seconds 15

Run-Service -Path "config-service" -Name "Config Service"
Write-Host "Waiting 20s for Config..."
Start-Sleep -Seconds 20

# 2. Backend Services
Write-Host "Phase 2: Backend Microservices" -ForegroundColor Yellow
Run-Service -Path "gateway-service" -Name "Gateway Service"
Run-Service -Path "customer-service" -Name "Customer Service"
Run-Service -Path "inventory-service" -Name "Inventory Service"
Run-Service -Path "billing-service" -Name "Billing Service"

# 3. Frontend
Write-Host "Phase 3: Frontend Web App" -ForegroundColor Yellow
$FrontendPath = "ecom-web-app"
if (Test-Path "$FrontendPath\node_modules") {
    Write-Host "node_modules found, skipping npm install."
}
else {
    Write-Host "Installing frontend dependencies..."
    # Use cmd for npm too
    Start-Process cmd -Wait -ArgumentList "/c", "cd /d $FrontendPath && npm install"
}

Write-Host "Starting Angular App..."
# Use cmd for npm start, this bypasses the ps1 wrapper check
Start-Process cmd -ArgumentList "/k", "cd /d $FrontendPath && npm start"

Write-Host "All services launched!" -ForegroundColor Green
Write-Host " Backend Dashboard: http://localhost:8761"
Write-Host " Frontend App:      http://localhost:4200"
