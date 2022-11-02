@ECHO OFF
@COLOR F
@TITLE Microsoft Store Reinstaller

ECHO Reinstalling Microsoft Store...

wsreset -i

ECHO Microsoft Store has been reinstalled!
PING 127.0.0.1 -n 5 >NUL
EXIT
