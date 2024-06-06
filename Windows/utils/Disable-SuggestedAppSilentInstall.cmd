@ECHO OFF
@COLOR F
@TITLE Disable silent installation of suggested apps

ECHO Disabling silent installation of suggested apps...
ECHO.

REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f

ECHO.
ECHO Done!
ECHO.
PAUSE
