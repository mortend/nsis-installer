; This installer uses UltraModernUI and ExecDos plugins.

!define NAME "fuse X"
;!define VERSION "1.14.0-canary.0"

!define NODE_VERSION "12.16.3"
!define NODE_MSI "node-v${NODE_VERSION}-x64.msi"
!define NODE_URL "https://nodejs.org/dist/v${NODE_VERSION}/${NODE_MSI}"
!define NPM_DIR "$APPDATA\npm"

!define GIT_VERSION "2.26.2"
!define GIT_MSI "Git-${GIT_VERSION}-64-bit.exe"
!define GIT_URL "https://github.com/git-for-windows/git/releases/download/v${GIT_VERSION}.windows.1/${GIT_MSI}"

!define JDK_MSI "OpenJDK8U-jdk_x64_windows_hotspot_8u252b09.msi"
!define JDK_URL "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u252-b09.1/OpenJDK8U-${JDK_MSI}"
!define JAVA_DIR "$PROGRAMFILES64\AdoptOpenJDK\jdk-8.0.252.09-hotspot"

!define ANDROID_INSTALL '"${WRAP}" npm install android-build-tools -g -f --prefix "${NPM_DIR}"'
!define FUSE_STUDIO_NAME "fuse-x-studio@${VERSION}"
!define FUSE_STUDIO_TGZ "fuse-x-studio-win-${VERSION}.tgz"
!define FUSE_STUDIO_INSTALL '"${WRAP}" npm install "${TEMP_DIR}\${FUSE_STUDIO_TGZ}" -g -f --prefix "${NPM_DIR}"'
!define FUSE_STUDIO_DIR "${NPM_DIR}\node_modules\@fuse-x\studio-win"
!define FUSE_STUDIO "${FUSE_STUDIO_DIR}\bin\Release\fuse-studio.exe"
!define FUSE "${FUSE_STUDIO_DIR}\bin\Release\fuse.exe"
!define UNO "${FUSE_STUDIO_DIR}\node_modules\@fuse-open\uno\bin\uno.exe"

!define REG_KEY "Software\Fuseapps\${NAME}\setup"
!define TEMP_DIR "$TEMP\fuse-setup"
!define WRAP "${TEMP_DIR}\wrap.cmd"

Unicode True
Name "${NAME}"
OutFile "..\..\fuse-x-${VERSION}-win.exe"
InstallDir "$PROGRAMFILES64\${NAME}"
InstallDirRegKey HKCU "${REG_KEY}" ""
RequestExecutionLevel admin
SetCompressor lzma
SpaceTexts none

;--------------------------------
;Interface Settings

  !include "UMUI.nsh"
  !define UMUI_ULTRAMODERN_SMALL

  !define MUI_TEXTCOLOR e6e6e6
  !define MUI_BGCOLOR 31343a
  !define UMUI_TEXT_LIGHTCOLOR 808080
  !define UMUI_HEADERTEXT_COLOR e6e6e6
  !define UMUI_BRANDINGTEXTFRONTCOLOR 31343a
  !define UMUI_BRANDINGTEXTBACKCOLOR 31343a
  !define UMUI_DISABLED_BUTTON_TEXT_COLOR 808080
  !define UMUI_SELECTED_BUTTON_TEXT_COLOR e6e6e6
  !define UMUI_BUTTON_TEXT_COLOR ffffff
  !define UMUI_LEFTIMAGE_BMP "skin\Left.bmp"
  !define UMUI_HEADERBGIMAGE_BMP "skin\Header.bmp"
  !define UMUI_BOTTOMIMAGE_BMP "skin\Bottom.bmp"
  !define UMUI_BUTTONIMAGE_BMP "skin\Button.bmp"
  !define UMUI_SCROLLBARIMAGE_BMP "skin\ScrollBarWhite.bmp"
  !define UMUI_PAGEBGIMAGE_BMP "skin\PageBG.bmp"
  !define MUI_WELCOMEFINISHPAGE_BITMAP "skin\Wizard.bmp"
  !define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH "skin\Wizard.bmp"
  !define MUI_ICON "icon.ico"
  !define MUI_UNICON "icon.ico"
  !define MUI_INSTFILESPAGE_COLORS "4e55db 31343a"
  !define MUI_INSTFILESPAGE_PROGRESSBAR "smooth colored"
  !define MUI_COMPONENTSPAGE_NODESC

  !define UMUI_USE_INSTALLOPTIONSEX
  !define UMUI_WELCOMEFINISHABORTPAGE_USE_IMAGE
  ;!define UMUI_PAGEBGIMAGE

  !define MUI_ABORTWARNING
  !define MUI_UNABORTWARNING

  !define UMUI_USE_ALTERNATE_PAGE
  !define UMUI_USE_UNALTERNATE_PAGE

;--------------------------------
;Pages

  !insertmacro UMUI_PAGE_MULTILANGUAGE
  ;!insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  ;!insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES

  !define MUI_FINISHPAGE_RUN
  ;!define MUI_FINISHPAGE_RUN_TEXT "Run ${NAME}"
  !define MUI_FINISHPAGE_RUN_FUNCTION "LaunchFuseStudio"
  !insertmacro MUI_PAGE_FINISH

  !insertmacro UMUI_UNPAGE_MULTILANGUAGE
  ;!insertmacro MUI_UNPAGE_WELCOME
  ;!insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  ;!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "Korean"
  !insertmacro MUI_LANGUAGE "Norwegian"

;--------------------------------
;Install types

  InstType "Typical"
  InstType "Complete"
  InstType "Minimal"

;--------------------------------
;Installer Sections

  !include "LogicLib.nsh"
  !include "sections.nsh"

Section "-wrap"

  SetOutPath "${TEMP_DIR}"
  File "wrap.cmd"

SectionEnd

SectionGroup "Fuse Studio"

Section "Node.js" SEC_NODE
SectionIn 1 2

  ; Installed later.

SectionEnd

Section "VC++ Redistributables"
SectionIn 1 2

  ; https://stackoverflow.com/questions/12206314/detect-if-visual-c-redistributable-for-visual-studio-2012-is-installed

  ReadRegStr $1 HKLM "SOFTWARE\Classes\Installer\Products\1926E8D15D0BCE53481466615F760A7F" "NUL:"
  ${If} $0 != "NUL:"
    DetailPrint "vcredist 2010 (x64) is installed already."
    Goto installed_2010
  ${EndIf}

  DetailPrint "Installing vcredist 2010 (x64)"
  NSISdl::download https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe vcredist_2010_x64.exe
  ExecWait "${TEMP_DIR}\vcredist_2010_x64.exe /q /norestart"
  Delete "${TEMP_DIR}\vcredist_2010_x64.exe"

installed_2010:
  ReadRegStr $1 HKLM "SOFTWARE\Classes\Installer\Dependencies\{ca67548a-5ebe-413a-b50c-4b9ceb6d66c6}" "NUL:"
  ${If} $0 != "NUL:"
    DetailPrint "vcredist 2012 (x64) is installed already."
    Goto installed_2012
  ${EndIf}

  DetailPrint "Installing vcredist 2012 (x64)"
  NSISdl::download https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe vcredist_2012_x64.exe
  ExecWait "${TEMP_DIR}\vcredist_2012_x64.exe /q /norestart"
  Delete "${TEMP_DIR}\vcredist_2012_x64.exe"

installed_2012:
  ReadRegStr $1 HKLM "SOFTWARE\Classes\Installer\Dependencies\{050d4fc8-5d48-4b8f-8972-47c82c46020f}" "NUL:"
  ${If} $0 != "NUL:"
    DetailPrint "vcredist 2013 (x64) is installed already."
    Goto installed_2013
  ${EndIf}

  DetailPrint "Installing vcredist 2013 (x64)"
  NSISdl::download https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe vcredist_2013_x64.exe
  ExecWait "${TEMP_DIR}\vcredist_2013_x64.exe /install /quiet /norestart"
  Delete "${TEMP_DIR}\vcredist_2013_x64.exe"

installed_2013:
SectionEnd

Section "Fuse Studio" SEC0000
SectionIn 1 2 3 RO

  ExecDos::exec 'cmd /c ""${WRAP}" npm --version"' ''
  Pop $0

  ${If} $0 == 0
    DetailPrint "npm is installed already."
    Goto install_fuse
  ${ElseIf} ${SectionIsSelected} ${SEC_NODE}
    Goto install_node
  ${EndIf}

  DetailPrint "Please install Node.js and try again."
  MessageBox MB_ICONQUESTION|MB_YESNO "Node.js is required, but could not be found.$\r$\n$\r$\nDo you want to install Node.js now?" /SD IDNO IDYES install_node IDNO abort_install

install_node:
  DetailPrint "Installing Node.js"
  NSISdl::download "${NODE_URL}" "${TEMP_DIR}\${NODE_MSI}"
  ExecWait 'msiexec.exe /i "${TEMP_DIR}\${NODE_MSI}" /qn'
  Delete "${TEMP_DIR}\${NODE_MSI}"
  Goto install_fuse

abort_install:
  Call Failed

install_fuse:
  File /oname=${FUSE_STUDIO_TGZ} ..\..\${FUSE_STUDIO_TGZ}

  ExecDos::exec 'taskkill /f /t /im unohost.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-tray.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-lang.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-studio.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-preview.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse.exe' ''

  ;NPM should handle removal of old versions already.
  ;RMDir /r /REBOOTOK "${FUSE_STUDIO_DIR}"

  DetailPrint "Installing ${FUSE_STUDIO_NAME}"
  ExecDos::exec /DETAILED 'cmd /c "${FUSE_STUDIO_INSTALL}"' ''
  Pop $0

  ${If} $0 != 0
    ;Try one more time.
    DetailPrint "Reinstalling ${FUSE_STUDIO_NAME}"
    ExecDos::exec /DETAILED 'cmd /c "${FUSE_STUDIO_INSTALL}"' ''
    Pop $0

    ${If} $0 != 0
      Delete "${TEMP_DIR}\${FUSE_STUDIO_TGZ}"
      Call Failed
    ${EndIf}
  ${EndIf}

  Delete "${TEMP_DIR}\${FUSE_STUDIO_TGZ}"

  SetOutPath "$INSTDIR"
  WriteRegStr HKCU "${REG_KEY}" "" $INSTDIR
  WriteUninstaller "$INSTDIR\uninstall.exe"

  FileOpen $9 your-files.txt w
  FileWrite $9 "Your files are located at:$\r$\n"
  FileWrite $9 "${FUSE_STUDIO_DIR}$\r$\n"
  FileClose $9

  CreateDirectory "$SMPROGRAMS\${NAME}"
  CreateShortCut "$SMPROGRAMS\${NAME}\${NAME}.lnk" "${FUSE_STUDIO}" "" "${FUSE_STUDIO}"
  CreateShortCut "$SMPROGRAMS\${NAME}\Uninstall ${NAME}.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe"

SectionEnd

Section "Warm-up"
SectionIn 1 2

  DetailPrint "Warming up"
  ExecDos::exec /DETAILED 'cmd /c ""${WRAP}" "${UNO}" build dotnet "${FUSE_STUDIO_DIR}\app""' ''
  Pop $0

  ${If} $0 != 0
    MessageBox MB_ICONEXCLAMATION|MB_OK "Warm-up failed."
  ${EndIf}

SectionEnd

SectionGroupEnd
SectionGroup "Android Support"

Section "Git for Windows" SEC_GIT
SectionIn 1 2

  ; Installed later.

SectionEnd

Section "Java Development Kit" SEC_JAVA
SectionIn 1 2

  ; Installed later.

SectionEnd

Section "Android Build Tools"
SectionIn 1 2

  ExecDos::exec 'cmd /c ""${WRAP}" git --version"' ''
  Pop $0

  ${If} $0 == 0
    DetailPrint "git is installed already."
    Goto check_java
  ${ElseIf} ${SectionIsSelected} ${SEC_GIT}
    Goto install_git
  ${EndIf}

  DetailPrint "Please install Git for Windows and try again."
  MessageBox MB_ICONQUESTION|MB_YESNO "Git for Windows is required, but could not be found.$\r$\n$\r$\nDo you want to install Git for Windows now?" /SD IDNO IDYES install_git IDNO install_android

install_git:
  DetailPrint "Installing Git for Windows"
  NSISdl::download "${GIT_URL}" "${TEMP_DIR}\${GIT_MSI}"
  ExecWait 'msiexec.exe /i "${TEMP_DIR}\${GIT_MSI}" /qn'
  Delete "${TEMP_DIR}\${GIT_MSI}"

check_java:
  ExecDos::exec 'cmd /c ""${WRAP}" java -version"' ''
  Pop $0

  ${If} $0 == 0
    DetailPrint "java is installed already."
    Goto install_android
  ${ElseIf} ${SectionIsSelected} ${SEC_JAVA}
    Goto install_java
  ${EndIf}

  DetailPrint "Please install Java Development Kit and try again."
  MessageBox MB_ICONQUESTION|MB_YESNO "Java Development Kit is required, but could not be found.$\r$\n$\r$\nDo you want to install Java Development Kit now?" /SD IDNO IDYES install_java IDNO install_android

install_java:
  DetailPrint "Installing Java Development Kit"
  NSISdl::download "${JDK_URL}" "${TEMP_DIR}\${JDK_MSI}"
  ExecWait 'msiexec.exe /i "${TEMP_DIR}\${JDK_MSI}" /qn'
  Delete "${TEMP_DIR}\${JDK_MSI}"

  System::Call 'Kernel32::SetEnvironmentVariable(t, t)i ("JAVA_HOME", "${JAVA_DIR}").r0'

install_android:
  DetailPrint "Installing android-build-tools"
  ExecDos::exec /DETAILED 'cmd /c "${ANDROID_INSTALL}"' ''
  Pop $0

  ${If} $0 != 0
    MessageBox MB_ICONEXCLAMATION|MB_OK "Android Build Tools failed to install."
  ${EndIf}

SectionEnd

SectionGroupEnd
SectionGroup /e "Text Editor Plugins"

Section "Visual Studio Code"
SectionIn 2

  ExecDos::exec 'cmd /c ""${WRAP}" code --version"' ''
  Pop $0

  ${If} $0 == 0
    DetailPrint "vscode is installed already."
    Goto install_extension
  ${EndIf}

  DetailPrint "Please install Visual Studio Code"
  MessageBox MB_ICONQUESTION|MB_YESNO "The 'code' command was not found on your computer.$\r$\n$\r$\nDo you want to install Visual Studio Code now?" /SD IDNO IDYES install_code IDNO install_extension

install_code:
  ExecShell "open" "https://code.visualstudio.com/download/"
  MessageBox MB_ICONINFORMATION|MB_OK "Please follow instructions on https://code.visualstudio.com/download/ to install Visual Studio Code."

install_extension:
  DetailPrint "Installing vscode-extension"
  ExecDos::exec /DETAILED 'cmd /c ""${WRAP}" "${FUSE}" install vscode-extension"' ''
  Pop $0

  ${If} $0 != 0
    MessageBox MB_ICONEXCLAMATION|MB_OK "The Visual Studio Code extension failed to install.$\r$\n$\r$\nYou can reinstall the extension later from the Tools menu in Fuse Studio."
  ${EndIf}

SectionEnd

Section "Sublime Text 3"
SectionIn 2

  IfFileExists "$SMPROGRAMS\Sublime Text 3.lnk" 0 +2
  Goto install_plugin

  ExecDos::exec 'cmd /c ""${WRAP}" subl --version"' ''
  Pop $0

  ${If} $0 == 0
    DetailPrint "sublime is installed already."
    Goto install_plugin
  ${EndIf}

  DetailPrint "Please install Sublime Text"
  MessageBox MB_ICONQUESTION|MB_YESNO "The 'subl' command was not found on your computer.$\r$\n$\r$\nDo you want to install Sublime Text now?" /SD IDNO IDYES install_sublime IDNO install_plugin

install_sublime:
  ExecShell "open" "https://www.sublimetext.com/3"
  MessageBox MB_ICONINFORMATION|MB_OK "Please follow instructions on https://www.sublimetext.com/3 to install Sublime Text."

install_plugin:
  DetailPrint "Installing sublime-plugin"
  ExecDos::exec /DETAILED 'cmd /c ""${WRAP}" "${FUSE}" install sublime-plugin"' ''
  Pop $0

  ${If} $0 != 0
    MessageBox MB_ICONEXCLAMATION|MB_OK "The Sublime Text plugin failed to install.$\r$\n$\r$\nYou can reinstall the plugin later from the Tools menu in Fuse Studio."
  ${EndIf}

SectionEnd

Section "Atom"
SectionIn 2

  DetailPrint "Installing atom-plugin"
  ExecDos::exec /DETAILED 'cmd /c ""${WRAP}" "${FUSE}" install atom-plugin"' ''
  Pop $0

  ${If} $0 != 0
    MessageBox MB_ICONEXCLAMATION|MB_OK "The Atom plugin failed to install.$\r$\n$\r$\nYou can reinstall the plugin later from the Tools menu in Fuse Studio."
  ${EndIf}

SectionEnd

SectionGroupEnd

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ExecDos::exec 'taskkill /f /t /im unohost.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-tray.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-lang.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-studio.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-preview.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse.exe' ''

  RMDir /r /REBOOTOK "$INSTDIR"
  RMDir /r /REBOOTOK "$SMPROGRAMS\${NAME}"
  RMDir /r /REBOOTOK "${FUSE_STUDIO_DIR}"
  RMDir /r /REBOOTOK "${TEMP_DIR}"

  Delete /REBOOTOK "${NPM_DIR}\fuse"
  Delete /REBOOTOK "${NPM_DIR}\fuse.cmd"
  Delete /REBOOTOK "${NPM_DIR}\fuse.ps1"
  Delete /REBOOTOK "${NPM_DIR}\uno"
  Delete /REBOOTOK "${NPM_DIR}\uno.cmd"
  Delete /REBOOTOK "${NPM_DIR}\uno.ps1"

  DeleteRegKey HKCU "${REG_KEY}"
  DeleteRegKey HKCU "Software\Classes\fusestudio"

  MessageBox MB_ICONQUESTION|MB_YESNO "Do you want to delete your configuration and log files?" /SD IDNO IDYES remove_userdata IDNO done

remove_userdata:
  RMDir /r /REBOOTOK "$LOCALAPPDATA\fuse X"

done:
SectionEnd


;--------------------------------
;Installer Functions

Function .onInit
  !insertmacro UMUI_MULTILANG_GET
  SectionSetFlags ${SEC0000} 17
FunctionEnd

Function .onGUIEnd
  RMDir /r /REBOOTOK "${TEMP_DIR}"
FunctionEnd

Function Failed
  DetailPrint "Install failed."
  SetDetailsView show
  Abort
FunctionEnd

Function LaunchFuseStudio
  HideWindow ;-)
  ExecDos::exec 'cmd /c ""${WRAP}" "${FUSE_STUDIO}""' ''
FunctionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit
  !insertmacro UMUI_MULTILANG_GET
FunctionEnd
