@echo off

set DIR=%APPDATA%\npm
set NPM=%DIR%\npm.cmd
set PATH=%PROGRAMFILES%\nodejs;%PATH%
set PATH=%PROGRAMW6432%\nodejs;%PATH%

if exist "%NPM%" (
    goto TEST
)

echo %NPM% not found
npm install npm -g -f --prefix "%DIR%"

if exist "%NPM%" (
    goto TEST
) else (
    exit /b 1
)

:TEST
call "%NPM%" --version
exit /b %ERRORLEVEL%
