@ECHO OFF
@COLOR F
@TITLE Windows Search Service Disabler

ECHO Disabling Windows Search(WSearch) service...
ECHO.

SC STOP WSearch
SC CONFIG WSearch start=disabled

ECHO.
ECHO Done!
PING 127.0.0.1 -n 10 >NUL 2>&1
EXIT
