@echo off
REM Script to fix wakelock namespace issue for Windows
REM This script will add namespace to wakelock android build.gradle

set WAKELOCK_PATH=%LOCALAPPDATA%\Pub\Cache\hosted\pub.dev\wakelock-0.6.2\android\build.gradle

if exist "%WAKELOCK_PATH%" (
    echo Found wakelock build.gradle at %WAKELOCK_PATH%
    
    REM Check if namespace already exists
    findstr /C:"namespace" "%WAKELOCK_PATH%" >nul
    if errorlevel 1 (
        echo Adding namespace to wakelock build.gradle
        
        REM Create a temporary file with the namespace added
        powershell -Command "(Get-Content '%WAKELOCK_PATH%') -replace 'android \{', ('android {' + [Environment]::NewLine + '    namespace \"com.github.creativecreatorormaybenot.wakelock\"') | Set-Content '%WAKELOCK_PATH%'"
        
        echo Namespace added successfully
    ) else (
        echo Cleaning up existing namespace attempt
        powershell -Command "(Get-Content '%WAKELOCK_PATH%') -replace 'android \{.*namespace.*', 'android {' | Set-Content '%WAKELOCK_PATH%'"
        
        echo Adding clean namespace to wakelock build.gradle
        powershell -Command "(Get-Content '%WAKELOCK_PATH%') -replace 'android \{', ('android {' + [Environment]::NewLine + '    namespace \"com.github.creativecreatorormaybenot.wakelock\"') | Set-Content '%WAKELOCK_PATH%'"
        
        echo Namespace fixed successfully
    )
) else (
    echo Wakelock build.gradle not found at %WAKELOCK_PATH%
)

pause
