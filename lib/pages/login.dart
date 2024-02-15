import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/pages/admin/admin.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:healman_mental_awareness/controller/internet_controller.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';
import 'package:healman_mental_awareness/pages/home.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/utils/snack_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController = RoundedLoadingButtonController();

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 300),
                child: Image.asset('assets/icon/logo.png'),
              ),
              RoundedLoadingButton(
                onPressed: () {
                  handleGoogleLogin();
                },
                controller: googleController,
                successColor: Colors.green,
                width: MediaQuery.of(context).size.width * 0.80,
                elevation: 0,
                color: Colors.white,
                valueColor: Colors.black,
                borderRadius: 10,
                child: Wrap(
                  children: [
                    const Text(
                      "Login dengan Google",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      'assets/icon/google.png',
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleGoogleLogin() async {
    final sp = context.read<LoginController>();
    final ip = context.read<InternetController>();
    await ip.checkInternetConnection();

    if (!ip.hasInternet) {
      openSnackbar(context, "Periksa jaringan internet anda", Colors.red);
      googleController.reset();
    } else {
      await sp.loginWithGoogle().then((value) {
        if (sp.hasErrors) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          sp.checkUser().then((value) async {
            if (value == true) {
              await sp.getUserDataFirestore(sp.uid).then((value) => sp.saveDataSharedPref().then((value) => sp.setLogin().then((value) {
                    googleController.success();
                    handleAfterLogin(sp.role); // Tambahkan peran pengguna sebagai parameter
                  })));
            } else {
              sp.saveDataUsers().then((value) => sp.saveDataSharedPref().then((value) => sp.setLogin().then((value) {
                    googleController.success();
                    handleAfterLogin(sp.role); // Tambahkan peran pengguna sebagai parameter
                  })));
            }
          });
        }
      });
    }
  }
  void handleAfterLogin(String? userRole) {
    // Memeriksa peran pengguna setelah login
    if (userRole == 'ADMIN') {
      // Jika pengguna adalah admin, arahkan ke halaman admin
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        nextPageReplace(context, AdminPage()); // Ganti dengan halaman admin yang sesuai
      });
    } else {
      // Jika pengguna adalah user, arahkan ke halaman home
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        nextPageReplace(context, const HomePage());
      });
    }
  }
}
