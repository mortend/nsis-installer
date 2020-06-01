@echo off

if "%JAVA_HOME%" neq "" (
    exit /b 0
)

set PATH=%PROGRAMW6432%\Android\Android Studio\jre\bin;%PATH%

where java
exit /b %ERRORLEVEL%
