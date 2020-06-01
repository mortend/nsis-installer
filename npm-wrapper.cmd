@echo off

set PATH=%PROGRAMFILES%\nodejs;%PATH%
set PATH=%PROGRAMW6432%\nodejs;%PATH%
set PATH=%APPDATA%\npm;%PATH%

call npm %*
