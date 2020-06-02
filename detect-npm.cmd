@echo off

call %~dp0wrap.cmd npm --version
exit /b %ERRORLEVEL%
