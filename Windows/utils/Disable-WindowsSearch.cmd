@ECHO OFF
@COLOR F
@TITLE Windows Search Service Disabler

ECHO Disabling Windows Search(WSearch) service...
ECHO.

SC STOP WSearch
SC CONFIG WSearch start=disabled

ECHO.
ECHO Done!
ECHO.
PAUSE
