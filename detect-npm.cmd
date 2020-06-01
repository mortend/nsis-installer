@echo off

call %~dp0npm-wrapper.cmd --version
exit /b %ERRORLEVEL%
