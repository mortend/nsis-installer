@echo off

:: Paths added during installation.
set PATH=%APPDATA%\npm;%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%
set PATH=%PROGRAMFILES%\Git\cmd;%PATH%
set PATH=%PROGRAMFILES%\nodejs;%PATH%
set PATH=%PROGRAMW6432%\AdoptOpenJDK\jdk-8.0.252.09-hotspot\bin;%PATH%
set PATH=%PROGRAMW6432%\Android\Android Studio\jre\bin;%PATH%
set PATH=%PROGRAMW6432%\Git\cmd;%PATH%
set PATH=%PROGRAMW6432%\Microsoft VS Code\bin;%PATH%
set PATH=%PROGRAMW6432%\nodejs;%PATH%

:: Run command.
%*
