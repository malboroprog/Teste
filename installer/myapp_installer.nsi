; installer/myapp_installer.nsi
!define APP_NAME "MyApp"
!define APP_VERSION "1.0.0"

!define APP_EXE_NAME "myapp.exe"
!define DIST_PATH "E:\\teste\\lua-5.5.0\\dist"
!define APP_EXE "${DIST_PATH}\\${APP_EXE_NAME}"
!define INSTALL_DIR "$PROGRAMFILES\\${APP_NAME}"

OutFile "myapp-setup-${APP_VERSION}.exe"
InstallDir "${INSTALL_DIR}"
RequestExecutionLevel admin

Page directory
Page instfiles

Section "Install"
  SetOutPath "$INSTDIR"
  File /oname=${APP_EXE_NAME} "${APP_EXE}"
  CreateDirectory "$SMPROGRAMS\\${APP_NAME}"
  CreateShortCut "$SMPROGRAMS\\${APP_NAME}\\${APP_NAME}.lnk" "$INSTDIR\\${APP_EXE_NAME}"
  CreateShortCut "$DESKTOP\\${APP_NAME}.lnk" "$INSTDIR\\${APP_EXE_NAME}"
  WriteUninstaller "$INSTDIR\\Uninstall.exe"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}" "UninstallString" "$INSTDIR\\Uninstall.exe"
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\\${APP_EXE_NAME}"
  Delete "$SMPROGRAMS\\${APP_NAME}\\${APP_NAME}.lnk"
  Delete "$DESKTOP\\${APP_NAME}.lnk"
  Delete "$INSTDIR\\Uninstall.exe"
  RMDir "$SMPROGRAMS\\${APP_NAME}"
  RMDir "$INSTDIR"
  DeleteRegKey HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}"
SectionEnd
