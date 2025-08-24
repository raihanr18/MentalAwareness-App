import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  // Firebase Instance
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
    // Remove hostedDomain to allow any Google account
    signInOption: SignInOption.standard,
  );

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasErrors = false;
  bool get hasErrors => _hasErrors;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _role;
  String? get role => _role;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _name;
  String? get name => _name;

  String? _bio;
  String? get bio => _bio;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  LoginController() {
    checkSignInUser();
  }

  // Method to update name
  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  // Method to update bio
  void updateBio(String newBio) {
    _bio = newBio;
    notifyListeners();
  }

  Future<void> tambahAdmin(String email) async {
    try {
      if (email.isEmpty) {
        throw 'Email tidak boleh kosong';
      }

      // Tambahkan admin ke Firestore dengan peran ADMIN
      await FirebaseFirestore.instance.collection('users').add({
        'email': email,
        'role': 'ADMIN',
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setLogin() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // Login Google
  Future loginWithGoogle() async {
    try {
      // Clear any previous errors
      _hasErrors = false;
      _errorCode = null;

      // Check Google Play Services availability first
      await googleSignIn.isSignedIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        try {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;

          if (googleSignInAuthentication.accessToken == null ||
              googleSignInAuthentication.idToken == null) {
            _errorCode = "Gagal mendapatkan token autentikasi";
            _hasErrors = true;
            notifyListeners();
            return;
          }

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          final UserCredential authResult =
              await firebaseAuth.signInWithCredential(credential);

          final User? userDetails = authResult.user;

          if (userDetails == null) {
            _errorCode = "Gagal mendapatkan data pengguna";
            _hasErrors = true;
            notifyListeners();
            return;
          }

          // Save user data
          _name = userDetails.displayName ?? "User";
          _email = userDetails.email;
          _uid = userDetails.uid;
          _imageUrl = userDetails.photoURL;
          _role = "USER";
          _bio = "Bio belum di isi";

          // Don't call saveDataSharedPref here, let the UI handle it
          notifyListeners();
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case 'account-exists-with-different-credentials':
              _errorCode =
                  "Akun ini sudah terdaftar, coba dengan akun yang lain";
              break;
            case 'invalid-credential':
              _errorCode = "Kredensial tidak valid";
              break;
            case 'operation-not-allowed':
              _errorCode = "Login Google tidak diizinkan";
              break;
            case 'user-disabled':
              _errorCode = "Akun pengguna telah dinonaktifkan";
              break;
            case 'user-not-found':
              _errorCode = "Pengguna tidak ditemukan";
              break;
            case 'wrong-password':
              _errorCode = "Password salah";
              break;
            default:
              _errorCode = "Kesalahan autentikasi: ${e.message}";
          }
          _hasErrors = true;
          notifyListeners();
        }
      } else {
        // User cancelled the sign-in
        _errorCode = "Login dibatalkan";
        _hasErrors = true;
        notifyListeners();
      }
    } catch (e) {
      // Handle specific Google Play Services errors
      String errorString = e.toString().toLowerCase();

      if (errorString.contains('google play services') ||
          errorString.contains('apiexception: 10') ||
          errorString.contains('sign_in_required') ||
          errorString.contains('service_missing') ||
          errorString.contains('service_version_update_required')) {
        _errorCode =
            "Google Play Services tidak tersedia atau perlu diupdate. Silakan:\n"
            "1. Update Google Play Services di emulator\n"
            "2. Restart emulator\n"
            "3. Atau gunakan device fisik";
      } else if (errorString.contains('network_error') ||
          errorString.contains('no internet')) {
        _errorCode = "Tidak ada koneksi internet. Periksa koneksi Anda.";
      } else if (errorString.contains('cancelled') ||
          errorString.contains('user_cancelled')) {
        _errorCode = "Login dibatalkan oleh pengguna";
      } else {
        _errorCode = "Kesalahan tidak terduga: ${e.toString()}";
      }

      _hasErrors = true;
      notifyListeners();
    }
  }

  // Alternative login method for testing (Development only)
  Future loginAsTestUser() async {
    try {
      _hasErrors = false;
      _errorCode = null;

      // Simulate test user data
      _name = "Test User";
      _email = "testuser@example.com";
      _uid = "test_user_${DateTime.now().millisecondsSinceEpoch}";
      _imageUrl = "assets/user.png"; // Use local asset instead of external URL
      _role = "USER";
      _bio = "Test user untuk development";

      await saveDataSharedPref();
      await setLogin();

      notifyListeners();
    } catch (e) {
      _errorCode = "Gagal login sebagai test user: ${e.toString()}";
      _hasErrors = true;
      notifyListeners();
    }
  }

  // Check if app is in debug mode
  bool get isDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  // Insert User
  Future getUserDataFirestore(uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((DocumentSnapshot snapshot) => {
                _uid = snapshot['uid'],
                _name = snapshot['name'],
                _email = snapshot['email'],
                _imageUrl = snapshot['image_url'],
                _role = snapshot['role'],
                _bio = snapshot['bio'] ?? "Bio belum di isi"
              });
    } catch (e) {
      _errorCode = "Gagal mengambil data pengguna: ${e.toString()}";
      _hasErrors = true;
      notifyListeners();
      rethrow;
    }
  }

  Future saveDataUsers() async {
    try {
      final DocumentReference r =
          FirebaseFirestore.instance.collection('users').doc(uid);
      await r.set({
        'name': _name,
        'email': _email,
        'image_url': _imageUrl,
        'role': _role,
        'bio': _bio,
        'uid': _uid,
      });
      notifyListeners();
    } catch (e) {
      _errorCode = "Gagal menyimpan data pengguna: ${e.toString()}";
      _hasErrors = true;
      notifyListeners();
      rethrow;
    }
  }

  Future updateDataUsers() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection('users').doc(uid);
    await r.update({
      'name': _name,
      'email': _email,
      'image_url': _imageUrl,
      'role': _role,
      'bio': _bio,
      'uid': _uid,
    });
    notifyListeners();
  }

  Future saveDataSharedPref() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('name', _name!);
    await s.setString('email', _email!);
    await s.setString('uid', _uid!);
    await s.setString('image_url', _imageUrl!);
    await s.setString('bio', _bio!);
    await s.setString('role', _role!);
    notifyListeners();
  }

  Future getDataSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _imageUrl = s.getString('image_url');
    _uid = s.getString('uid');
    _bio = s.getString('bio');
    _role = s.getString('role');
    notifyListeners();
  }

  // Check User
  Future<bool> checkUser() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      // print('Pengguna Sudah Ada'); // Commented out for production
      return true;
    } else {
      // print('Pengguna Baru'); // Commented out for production
      return false;
    }
  }

  // Log out
  Future userLogout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();

    _isSignedIn = false;
    notifyListeners();

    cleareStoredData();
  }

  Future cleareStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}
