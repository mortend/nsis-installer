@echo off

set DIR=%APPDATA%\npm
set NPM=%DIR%\npm.cmd
set PATH=%PROGRAMFILES%\nodejs;%PATH%
set PATH=%PROGRAMW6432%\nodejs;%PATH%

if exist "%NPM%" (
    exit /b 0
)

echo %NPM% not found
npm install npm -g -f --prefix "%DIR%"

if exist "%NPM%" (
    exit /b 0
) else (
    exit /b 1
)
