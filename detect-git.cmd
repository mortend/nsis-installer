@echo off

set PATH=%PROGRAMFILES%\Git\cmd;%PATH%
set PATH=%PROGRAMW6432%\Git\cmd;%PATH%

where git
exit /b %ERRORLEVEL%
