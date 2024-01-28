import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier {
  // Firebase Instance
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasErrors = false;
  bool get hasErrors => _hasErrors;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get provider => _provider;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _name;
  String? get name => _name;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setLogin() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // Login Google
  Future loginWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;

        // Save user data
        _name = userDetails.displayName;
        _email = userDetails.email;
        _uid = userDetails.uid;
        _imageUrl = userDetails.photoURL;
        _provider = "GOOGLE";
        _uid = userDetails.uid;
        // _isSignedIn = true;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'account-exists-with-different-credentials':
            _errorCode = "Akun ini sudah terdaftar, coba dengan akun yang lain";
            _hasErrors = true;
            notifyListeners();
            break;
          case 'null':
            _errorCode = "Beberapa kesalahan tak terduga saat mencoba masuk";
            _hasErrors = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasErrors = true;
            notifyListeners();
        }
      }
    } else {
      _hasErrors = true;
      notifyListeners();
    }
  }

  // Insert User
  Future getUserDataFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid = snapshot['uid'],
              _name = snapshot['name'],
              _email = snapshot['email'],
              _imageUrl = snapshot['image_url'],
              _provider = snapshot['provider'],
            });
  }

  Future saveDataUsers() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection('users').doc(uid);
    await r.set({
      'name': _name,
      'email': _email,
      'image_url': _imageUrl,
      'provider': _provider,
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
    await s.setString('provider', _provider!);
    notifyListeners();
  }

  Future getDataSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _imageUrl = s.getString('image_url');
    _uid = s.getString('uid');
    _provider = s.getString('provider');
    notifyListeners();
  }

  // Check User
  Future<bool> checkUser() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      print('Pengguna Sudah Ada');
      return true;
    } else {
      print('Pengguna Baru');
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