; This installer uses UltraModernUI and ExecDos plugins.

!define NAME "fuse X"
;!define VERSION "1.14.0-canary.0"

!define NODE_VERSION "v10.16.1"
!define NODE_MSI "node-${NODE_VERSION}-x64.msi"
!define NODE_URL "https://nodejs.org/dist/${NODE_VERSION}/${NODE_MSI}"
!define NPM_DIR "$APPDATA\npm"
!define NPM "${NPM_DIR}\npm.cmd"

!define ANDROID_INSTALL '"${NPM}" install android-build-tools -g -f'
!define FUSE_STUDIO_NAME "fuse-studio-win-@${VERSION}"
!define FUSE_STUDIO_TGZ "fuse-studio-win-${VERSION}.tgz"
!define FUSE_STUDIO_INSTALL '"${NPM}" install "${TEMP_DIR}\${FUSE_STUDIO_TGZ}" -g -f'
!define FUSE_STUDIO_DIR "${NPM_DIR}\node_modules\fuse-studio-win"
!define FUSE_STUDIO "${FUSE_STUDIO_DIR}\bin\Release\Fuse Studio.exe"
!define TEMP_DIR "$TEMP\fuse-setup"
!define REG_KEY "Software\Fuseapps\${NAME}\setup"

Unicode True
Name "${NAME}"
OutFile "..\..\fuse-x-${VERSION}-win.exe"
InstallDir "$PROGRAMFILES\${NAME}"
InstallDirRegKey HKCU "${REG_KEY}" ""
RequestExecutionLevel admin
SetCompressor lzma

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
  !define UMUI_SELECTED_BUTTON_TEXT_COLOR 15191e
  !define UMUI_BUTTON_TEXT_COLOR 45c8e6
  !define UMUI_LEFTIMAGE_BMP "skin\Left.bmp"
  !define UMUI_HEADERBGIMAGE_BMP "skin\Header.bmp"
  !define UMUI_BOTTOMIMAGE_BMP "skin\Bottom.bmp"
  !define UMUI_BUTTONIMAGE_BMP "skin\Button.bmp"
  !define UMUI_SCROLLBARIMAGE_BMP "skin\ScrollBarWhite.bmp"
  !define UMUI_PAGEBGIMAGE_BMP "skin\PageBG.bmp"
  !define MUI_WELCOMEFINISHPAGE_BITMAP "skin\Wizard.bmp"
  !define MUI_ICON "icon.ico"
  !define MUI_UNICON "icon.ico"
  !define MUI_INSTFILESPAGE_COLORS "50e645 31343a"
  !define MUI_INSTFILESPAGE_PROGRESSBAR "smooth colored"

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

  !define MUI_FINISHPAGE_RUN "${FUSE_STUDIO}"
  !define MUI_FINISHPAGE_RUN_TEXT "Run ${NAME}"
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

;--------------------------------
;Installer Sections

  !include "LogicLib.nsh"

Section "Fuse Studio" SEC0000

retry:
  IfFileExists "${NPM}" begin_install 0

  DetailPrint "Not found: ${NPM}"
  DetailPrint "Please install Node.js and try again."
  MessageBox MB_ICONQUESTION|MB_YESNO "Node.js is required, but could not be found.$\r$\n$\r$\nDo you want to install Node.js now?" /SD IDNO IDYES install_nodejs IDNO abort_install

install_nodejs:
  NSISdl::download "${NODE_URL}" "${TEMP_DIR}\${NODE_MSI}"
  ExecWait 'msiexec.exe /i "${TEMP_DIR}\${NODE_MSI}" /qn'
  Delete "${TEMP_DIR}\${NODE_MSI}"
  Goto retry

abort_install:
  DetailPrint "Aborted."
  SetDetailsView show
  Abort

begin_install:
  SetOutPath "${TEMP_DIR}"

  File vcredist_2010_x64.exe
  ExecWait "${TEMP_DIR}\vcredist_2010_x64.exe /q /norestart"
  Delete "${TEMP_DIR}\vcredist_2010_x64.exe"

  File vcredist_2012_x64.exe
  ExecWait "${TEMP_DIR}\vcredist_2012_x64.exe /q /norestart"
  Delete "${TEMP_DIR}\vcredist_2012_x64.exe"

  File vcredist_2013_x64.exe
  ExecWait "${TEMP_DIR}\vcredist_2013_x64.exe /install /quiet /norestart"
  Delete "${TEMP_DIR}\vcredist_2013_x64.exe"

  File /oname=${FUSE_STUDIO_TGZ} ..\..\${FUSE_STUDIO_TGZ}
  DetailPrint "Installing ${FUSE_STUDIO_NAME}"

  ExecDos::exec 'taskkill /f /t /im uno-host.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-tray.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-ninja.exe' ''
  ExecDos::exec 'taskkill /f /t /im "Fuse Studio.exe"' ''
  ExecDos::exec 'taskkill /f /t /im fuse-preview.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse.exe' ''
  RMDir /r /REBOOTOK "${FUSE_STUDIO_DIR}"
  ExecDos::exec /DETAILED 'cmd /c "${FUSE_STUDIO_INSTALL}"' ''
  Pop $0

  ${If} $0 != 0
    ;Try one more time.
    DetailPrint "Reinstalling ${FUSE_STUDIO_NAME}"
    ExecDos::exec /DETAILED 'cmd /c "${FUSE_STUDIO_INSTALL}"' ''
    Pop $0

    ${If} $0 != 0
      Delete "${TEMP_DIR}\${FUSE_STUDIO_TGZ}"
      DetailPrint "Install failed."
      SetDetailsView show
      Abort
    ${EndIf}
  ${EndIf}

  Delete "${TEMP_DIR}\${FUSE_STUDIO_TGZ}"

  SetOutPath "$INSTDIR"
  WriteRegStr HKCU "${REG_KEY}" "" $INSTDIR
  WriteUninstaller "$INSTDIR\uninstall.exe"

  CreateDirectory "$SMPROGRAMS\${NAME}"
  CreateShortCut "$SMPROGRAMS\${NAME}\${NAME}.lnk" "${FUSE_STUDIO}" "" "${FUSE_STUDIO}"
  CreateShortCut "$SMPROGRAMS\${NAME}\Uninstall ${NAME}.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe"

SectionEnd

Section "Android Build Tools"

  ExecDos::exec /DETAILED 'cmd /c "${ANDROID_INSTALL}"' ''

SectionEnd

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ExecDos::exec 'taskkill /f /t /im uno-host.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-tray.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse-ninja.exe' ''
  ExecDos::exec 'taskkill /f /t /im "Fuse Studio.exe"' ''
  ExecDos::exec 'taskkill /f /t /im fuse-preview.exe' ''
  ExecDos::exec 'taskkill /f /t /im fuse.exe' ''

  RMDir /r /REBOOTOK "$INSTDIR"
  RMDir /r /REBOOTOK "$SMPROGRAMS\${NAME}"
  RMDir /r /REBOOTOK "${FUSE_STUDIO_DIR}"
  RMDir /r /REBOOTOK "${TEMP_DIR}"
  DeleteRegKey HKCU "${REG_KEY}"

SectionEnd

;--------------------------------
;Installer Functions

Function .onInit
  !insertmacro UMUI_MULTILANG_GET
  SectionSetFlags ${SEC0000} 17
FunctionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit
  !insertmacro UMUI_MULTILANG_GET
FunctionEnd
