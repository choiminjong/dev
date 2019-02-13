@echo off

set "CATALINA_HOME=C:\Dev\server\apache-tomcat-6.0.33-80"
set "STOP=%CATALINA_HOME%\bin\shutdown.bat"
set "START=%CATALINA_HOME%\bin\startup.bat"

@echo on
call %STOP%
timeout /t 2
call %START%
timeout /t 2
