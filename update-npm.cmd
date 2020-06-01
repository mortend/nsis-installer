@echo off

set NPM=%APPDATA%\npm\npm.cmd
set PATH=%PROGRAMFILES%\nodejs;%PATH%

if exist "%NPM%" (
    exit /b 0
)

echo %NPM% not found
npm install npm -g -f

if exist "%NPM%" (
    exit /b 0
) else (
    exit /b 1
)
