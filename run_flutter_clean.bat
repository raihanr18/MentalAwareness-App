@echo off
echo 🚀 Running Flutter with clean output...
echo 📱 Buffer warnings will be filtered out

flutter run --hot 2>&1 | findstr /v /c:"ImageReader_JNI" | findstr /v /c:"Unable to acquire a buffer" | findstr /v /c:"BufferPoolAccessor" | findstr /v /c:"EGL_emulation" | findstr /v /c:"CCodec" | findstr /v /c:"MediaCodec" | findstr /v /c:"ReflectedParamUpdater"

echo.
echo ✅ Flutter session ended
pause
