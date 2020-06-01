@echo off

set PATH=%PROGRAMW6432%\Android\Android Studio\jre\bin;%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%

where java
exit /b %ERRORLEVEL%
