@ECHO OFF
@COLOR F
@TITLE OneDrive Uninstaller

SET x86="%SystemRoot%\System32\OneDriveSetup.exe"
SET x64="%SystemRoot%\SysWOW64\OneDriveSetup.exe"

ECHO.
ECHO.
ECHO Closing OneDrive processes...
ECHO.
TASKKILL /F /IM OneDrive.exe >NUL 2>&1
PING 127.0.0.1 -n 5 >NUL 2>&1

ECHO.
ECHO.
ECHO Uninstalling OneDrive...
ECHO.
IF EXIST %x64% (
  ECHO * Found x64 installer
  %x64% /uninstall
)
IF EXIST %x86% (
  ECHO * Found x86 installer
  %x86% /uninstall
)
PING 127.0.0.1 -n 5 >NUL 2>&1

ECHO.
ECHO.
ECHO Removing OneDrive leftovers...
ECHO.
RMDIR /Q /S "%UserProfile%\OneDrive" >NUL 2>&1
RMDIR /Q /S "%SystemDrive%:\OneDriveTemp" >NUL 2>&1
RMDIR /Q /S "%LocalAppData%\Microsoft\OneDrive" >NUL 2>&1
RMDIR /Q /S "%ProgramData%\Microsoft OneDrive" >NUL 2>&1

ECHO.
ECHO.
ECHO Removing OneDrive from the Windows Explorer Side Panel...
ECHO.
REG DELETE /F "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" >NUL 2>&1
REG DELETE /F "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" >NUL 2>&1

ECHO.
ECHO.
ECHO Done!
PING 127.0.0.1 -n 10 >NUL 2>&1
EXIT
