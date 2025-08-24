@echo off
echo ========================================
echo     Google Play Services Debug Guide
echo ========================================
echo.

echo 1. Getting SHA-1 Fingerprint for Debug...
echo.

cd /d "%~dp0android"

echo Debug SHA-1:
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android | findstr SHA1

echo.
echo 2. Alternative method using gradlew:
echo.

call gradlew signingReport 2>nul | findstr SHA1

echo.
echo ========================================
echo INSTRUCTIONS:
echo ========================================
echo 1. Copy the SHA1 fingerprint above
echo 2. Go to Firebase Console: https://console.firebase.google.com
echo 3. Select your project: mentalawareness-healman
echo 4. Go to Project Settings ^> General
echo 5. In "Your apps" section, click on Android app
echo 6. Click "Add fingerprint" 
echo 7. Paste the SHA1 fingerprint
echo 8. Save the changes
echo.
echo 9. Then restart the emulator:
echo    flutter run --device-id emulator-5554
echo.
echo ========================================

pause
