@ECHO OFF
@COLOR F
@TITLE .NET Framework Assembly Precompiler

ECHO Precompiling .NET Framework assemblies...
ECHO.

%SystemRoot%\Microsoft.NET\Framework64\v4.0.30319\ngen.exe executeQueuedItems
%SystemRoot%\Microsoft.NET\Framework64\v2.0.50727\ngen.exe executeQueuedItems
%SystemRoot%\Microsoft.NET\Framework\v4.0.30319\ngen.exe executeQueuedItems
%SystemRoot%\Microsoft.NET\Framework\v2.0.50727\ngen.exe executeQueuedItems

ECHO.
ECHO Done!
PING 127.0.0.1 -n 10 >NUL 2>&1
EXIT
