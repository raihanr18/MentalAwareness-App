@echo off
REM Comprehensive script to fix namespace issues for all problematic plugins
REM This script will add namespace to multiple android build.gradle files

echo Fixing namespace issues for Flutter plugins...

REM Fix wakelock
set WAKELOCK_PATH=%LOCALAPPDATA%\Pub\Cache\hosted\pub.dev\wakelock-0.6.2\android\build.gradle
if exist "%WAKELOCK_PATH%" (
    echo Fixing wakelock namespace...
    powershell -Command "(Get-Content '%WAKELOCK_PATH%') -replace 'android \{(?!.*namespace)', ('android {' + [Environment]::NewLine + '    namespace \"com.github.creativecreatorormaybenot.wakelock\"') | Set-Content '%WAKELOCK_PATH%'"
    echo Wakelock namespace fixed
) else (
    echo Wakelock build.gradle not found
)

REM Fix webview_flutter_android
set WEBVIEW_PATH=%LOCALAPPDATA%\Pub\Cache\hosted\pub.dev\webview_flutter_android-2.10.4\android\build.gradle
if exist "%WEBVIEW_PATH%" (
    echo Fixing webview_flutter_android namespace...
    powershell -Command "(Get-Content '%WEBVIEW_PATH%') -replace 'android \{(?!.*namespace)', ('android {' + [Environment]::NewLine + '    namespace \"io.flutter.plugins.webviewflutter\"') | Set-Content '%WEBVIEW_PATH%'"
    echo Webview_flutter_android namespace fixed
) else (
    echo Webview_flutter_android build.gradle not found
)

REM Fix video_player_android
set VIDEO_PATH=%LOCALAPPDATA%\Pub\Cache\hosted\pub.dev\video_player_android-2.8.12\android\build.gradle
if exist "%VIDEO_PATH%" (
    echo Fixing video_player_android namespace...
    powershell -Command "(Get-Content '%VIDEO_PATH%') -replace 'android \{(?!.*namespace)', ('android {' + [Environment]::NewLine + '    namespace \"io.flutter.plugins.videoplayer\"') | Set-Content '%VIDEO_PATH%'"
    echo Video_player_android namespace fixed
) else (
    echo Video_player_android build.gradle not found
)

REM Fix audioplayers_android
set AUDIO_PATH=%LOCALAPPDATA%\Pub\Cache\hosted\pub.dev\audioplayers_android-4.0.3\android\build.gradle
if exist "%AUDIO_PATH%" (
    echo Fixing audioplayers_android namespace...
    powershell -Command "(Get-Content '%AUDIO_PATH%') -replace 'android \{(?!.*namespace)', ('android {' + [Environment]::NewLine + '    namespace \"xyz.luan.audioplayers\"') | Set-Content '%AUDIO_PATH%'"
    echo Audioplayers_android namespace fixed
) else (
    echo Audioplayers_android build.gradle not found
)

echo All namespace fixes completed!
pause
