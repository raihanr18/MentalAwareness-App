# Solusi Google Play Services Tidak Tersedia

## 🔍 **Masalah Yang Dialami**
Popup error: "Device ini tidak tersedia Google Play Service" meskipun sudah menginstall Google Play Services di emulator.

## 🎯 **Solusi Lengkap**

### **Metode 1: Update Emulator dengan Google Play**

1. **Buka Android Studio**
2. **Tools > AVD Manager**
3. **Create Virtual Device**
4. **Pilih device (misal: Pixel 7 Pro)**
5. **Pilih System Image dengan "Play Store" icon** ⭐
6. **Jangan pilih yang hanya "Google APIs"**
7. **Finish dan Launch emulator baru**

### **Metode 2: Update Google Play Services di Emulator Current**

1. **Di emulator, buka Play Store**
2. **Search "Google Play Services"**
3. **Update ke versi terbaru**
4. **Restart emulator**
5. **Jalankan: `flutter run --device-id emulator-5554`**

### **Metode 3: Fix SHA-1 Fingerprint di Firebase**

1. **Buka PowerShell sebagai Administrator**
2. **Jalankan command berikut:**
```powershell
keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

3. **Copy SHA1 fingerprint yang muncul**
4. **Buka Firebase Console: https://console.firebase.google.com**
5. **Pilih project: mentalawareness-healman**
6. **Project Settings > General**
7. **Di "Your apps" section, pilih Android app**
8. **Add fingerprint dan paste SHA1**
9. **Save changes**

### **Metode 4: Gunakan Device Fisik (Recommended)**

1. **Enable Developer Options di HP Android**
2. **Enable USB Debugging**
3. **Sambungkan HP ke komputer**
4. **Jalankan: `flutter devices`**
5. **Jalankan: `flutter run`**

## 🔧 **Command Quick Fix**

```bash
# Check devices
flutter devices

# Run on specific device
flutter run --device-id [DEVICE_ID]

# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

## 📱 **Cek Emulator yang Benar**

Pastikan emulator Anda memiliki:
- ✅ **Google Play Store** (bukan hanya Google APIs)
- ✅ **Google Play Services** versi terbaru
- ✅ **Android API 28+** (Android 9+)
- ✅ **x86_64 architecture**

## 🎯 **Error Handling yang Diperbaiki**

App sekarang memberikan pesan error yang lebih jelas:

```
"Google Play Services tidak tersedia atau perlu diupdate. Silakan:
1. Update Google Play Services di emulator
2. Restart emulator  
3. Atau gunakan device fisik"
```

## 🚀 **Testing Flow**

1. **Buka app**
2. **Tap "Login dengan Google"**
3. **Jika muncul error Google Play Services:**
   - Follow Metode 1-4 di atas
4. **Jika berhasil:**
   - Pilih akun Google
   - Login akan berhasil dan redirect ke HomePage

## 📋 **Troubleshooting Checklist**

- [ ] Emulator memiliki Google Play Store (bukan hanya APIs)
- [ ] Google Play Services sudah diupdate ke versi terbaru
- [ ] SHA-1 fingerprint sudah ditambahkan ke Firebase Console
- [ ] Internet connection stable
- [ ] Emulator sudah direstart setelah update

## 🎉 **Expected Result**

Setelah mengikuti salah satu metode di atas, Google Sign-In akan berfungsi normal dan user bisa login ke aplikasi tanpa error popup.
