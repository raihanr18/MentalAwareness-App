# Google Play Services Fix Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Google Play Services Debug Guide" -ForegroundColor Cyan  
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "1. Getting SHA-1 Fingerprint for Debug..." -ForegroundColor Yellow
Write-Host ""

$debugKeystore = "$env:USERPROFILE\.android\debug.keystore"

if (Test-Path $debugKeystore) {
    Write-Host "Debug SHA-1:" -ForegroundColor Green
    $sha1 = keytool -list -v -keystore $debugKeystore -alias androiddebugkey -storepass android -keypass android 2>$null | Select-String "SHA1"
    
    if ($sha1) {
        Write-Host $sha1 -ForegroundColor White
        Write-Host ""
        
        # Extract just the fingerprint
        $fingerprint = ($sha1 -split "SHA1: ")[1]
        Write-Host "Clean SHA-1 Fingerprint: $fingerprint" -ForegroundColor Green
        
        # Copy to clipboard if possible
        try {
            $fingerprint | Set-Clipboard
            Write-Host "✅ SHA-1 copied to clipboard!" -ForegroundColor Green
        } catch {
            Write-Host "⚠️ Could not copy to clipboard, please copy manually" -ForegroundColor Yellow
        }
    } else {
        Write-Host "❌ Could not extract SHA-1" -ForegroundColor Red
    }
} else {
    Write-Host "❌ Debug keystore not found at: $debugKeystore" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "FIREBASE CONFIGURATION STEPS:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "1. Go to: https://console.firebase.google.com" -ForegroundColor White
Write-Host "2. Select project: mentalawareness-healman" -ForegroundColor White  
Write-Host "3. Project Settings > General" -ForegroundColor White
Write-Host "4. Android app > Add fingerprint" -ForegroundColor White
Write-Host "5. Paste the SHA-1 fingerprint above" -ForegroundColor White
Write-Host "6. Save changes" -ForegroundColor White
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "EMULATOR CONFIGURATION:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Make sure your emulator has:" -ForegroundColor White
Write-Host "✅ Google Play Store (not just Google APIs)" -ForegroundColor Green
Write-Host "✅ Updated Google Play Services" -ForegroundColor Green  
Write-Host "✅ Android API 28+ (Android 9+)" -ForegroundColor Green
Write-Host ""
Write-Host "Current emulator info:" -ForegroundColor Yellow
flutter devices

Write-Host ""
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
