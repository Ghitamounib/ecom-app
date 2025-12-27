# Build and Run Script for Ecom App
# Updated: Uses 'mvnw.cmd' (Maven Wrapper) to avoid PATH issues.

Function Run-Service {
    param([string]$Path, [string]$Name)
    Write-Host "Starting $Name..." -ForegroundColor Cyan
    # Use full path to mvnw.cmd to be safe
    $MvnwPath = Resolve-Path ".\mvnw.cmd"
    
    # Start process using the wrapper
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd $Path; & '$MvnwPath' spring-boot:run"
}

# 1. Start Infrastructure
Write-Host "Phase 1: Starting Infrastructure..." -ForegroundColor Yellow

Run-Service -Path "discovery-service" -Name "Discovery Service"
Write-Host "Waiting 20s for Discovery..."
Start-Sleep -Seconds 20

Run-Service -Path "config-service" -Name "Config Service"
Write-Host "Waiting 30s for Config..."
Start-Sleep -Seconds 30

# 2. Start Backend
Write-Host "Phase 2: Starting Backend Services..." -ForegroundColor Yellow

Run-Service -Path "gateway-service" -Name "Gateway Service"
Run-Service -Path "customer-service" -Name "Customer Service"
Run-Service -Path "inventory-service" -Name "Inventory Service"
Run-Service -Path "billing-service" -Name "Billing Service"

Write-Host "All services launched using Maven Wrapper."
Write-Host "Please check the opened windows for errors."
