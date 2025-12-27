$JavaHome = "C:\Program Files\Java\jdk-17"
$env:JAVA_HOME = $JavaHome
$env:Path = "$JavaHome\bin;" + $env:Path

Write-Host "Starting Chatbot Service..." -ForegroundColor Cyan
cd chatbot-service
..\mvnw.cmd spring-boot:run
