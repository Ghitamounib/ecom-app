$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"
$env:Path = "$env:JAVA_HOME\bin;$env:Path"
cd billing-service
..\mvnw.cmd spring-boot:run -e > ..\billing_error_log.txt 2>&1
