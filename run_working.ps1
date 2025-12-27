# Robust Startup Script
# Forces JAVA_HOME to the detected installation path.

$JavaExe = "C:\Program Files\Java\jdk-17\bin\java.exe"
$JavaHome = "C:\Program Files\Java\jdk-17"

if (-not (Test-Path $JavaExe)) {
    Write-Host "Error: Java not found at $JavaExe" -ForegroundColor Red
    exit 1
}

Write-Host "Setting JAVA_HOME to $JavaHome" -ForegroundColor Green
$env:JAVA_HOME = $JavaHome
$env:Path = "$JavaHome\bin;$env:Path"

# Check version
java -version

Function Run-Service {
    param([string]$Path, [string]$Name)
    Write-Host "Starting $Name..." -ForegroundColor Cyan
    $MvnwPath = Resolve-Path ".\mvnw.cmd"
    
    # We must pass the Env vars to the new process, or set them globally for the session if possible.
    # Start-Process starts a new session. We need to pass the env setup.
    
    $Command = "
        `$env:JAVA_HOME = '$JavaHome';
        `$env:Path = '$JavaHome\bin;' + `$env:Path;
        cd $Path; 
        & '$MvnwPath' spring-boot:run
    "
    
    Start-Process powershell -ArgumentList "-NoExit", "-Command", $Command
}

# 1. Infrastructure
Run-Service -Path "discovery-service" -Name "Discovery Service"
Start-Sleep -Seconds 25

Run-Service -Path "config-service" -Name "Config Service"
Start-Sleep -Seconds 30

# 2. Backend
Run-Service -Path "gateway-service" -Name "Gateway Service"
Run-Service -Path "customer-service" -Name "Customer Service"
Run-Service -Path "inventory-service" -Name "Inventory Service"
Run-Service -Path "billing-service" -Name "Billing Service"

Write-Host "Launch initiated with JDK 17."
