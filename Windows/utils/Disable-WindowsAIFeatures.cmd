@ECHO OFF
@COLOR F
@TITLE Disable Windows AI features

ECHO Disabling Windows AI features...
ECHO.

ECHO Windows Copilot
REG ADD "HKLM\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f

ECHO AI data analysis (Windows Recall)
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f

ECHO.
ECHO Done!
ECHO.
PAUSE
