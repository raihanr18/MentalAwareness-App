// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mentalhealth/components/loading.dart';
import 'package:mentalhealth/controller/internet_controller.dart';
import 'package:mentalhealth/controller/login_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isGoogleLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Image.asset(
                      'assets/icon/logo.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: ElevatedButton(
                      onPressed: isGoogleLoading
                          ? null
                          : () {
                              handleGoogleLogin();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: isGoogleLoading
                          ? const LoadingAnimation()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icon/google.png',
                                  height: 25,
                                  width: 25,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Masuk dengan Google',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<LoginController>(
                    builder: (context, loginController, child) {
                      if (loginController.isDevelopmentMode) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          margin: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              handleTestLogin();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text(
                              'Login sebagai Test User (Dev Mode)',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleGoogleLogin() async {
    final sp = context.read<LoginController>();
    final ip = context.read<InternetController>();

    setState(() {
      isGoogleLoading = true;
    });

    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar("Periksa koneksi internet Anda", Colors.red);
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(sp.errorCode, Colors.red);
          setState(() {
            isGoogleLoading = false;
          });
        } else {
          sp.checkUserExists().then((value) {
            if (value == true) {
              sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        setState(() {
                          isGoogleLoading = false;
                        });
                        Navigator.pushReplacementNamed(context, '/home');
                      })));
            } else {
              Navigator.pushReplacementNamed(context, '/user-form');
              setState(() {
                isGoogleLoading = false;
              });
            }
          });
        }
      });
    }
  }

  Future<void> handleTestLogin() async {
    final sp = context.read<LoginController>();

    try {
      await sp.loginAsTestUser();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      openSnackbar("Test login error: $e", Colors.red);
    }
  }

  openSnackbar(String snackMessage, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(snackMessage),
      ),
    );
  }
}
