# Start Missing Services (Customer, Billing)
# Forces JAVA_HOME to the detected installation path.

$JavaExe = "C:\Program Files\Java\jdk-17\bin\java.exe"
$JavaHome = "C:\Program Files\Java\jdk-17"

Function Run-Service {
    param([string]$Path, [string]$Name)
    Write-Host "Starting $Name..." -ForegroundColor Cyan
    $MvnwPath = Resolve-Path ".\mvnw.cmd"
    
    $Command = "
        `$env:JAVA_HOME = '$JavaHome';
        `$env:Path = '$JavaHome\bin;' + `$env:Path;
        cd $Path; 
        & '$MvnwPath' spring-boot:run
    "
    
    Start-Process powershell -ArgumentList "-NoExit", "-Command", $Command
}

# Start Missing Backend Services
Run-Service -Path "customer-service" -Name "Customer Service"
Run-Service -Path "billing-service" -Name "Billing Service"

Write-Host "Attempting to launch missing services..."
