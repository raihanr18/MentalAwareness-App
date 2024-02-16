import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class KelolaAdmin extends StatefulWidget {
  const KelolaAdmin({super.key});

  @override
  State<KelolaAdmin> createState() => _KelolaAdminState();
}

class _KelolaAdminState extends State<KelolaAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegExp =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Admin',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Admin'),
              cursorColor: Colors.blue.shade100,
              validator: _validateEmail, // Add validator here
            ),
            const SizedBox(height: 20),
            RoundedLoadingButton(
              onPressed: () {
                _tambahAdmin(context);
                _buttonController.reset();
                _buttonController.success();
              },
              color: Colors.blue.shade100,
              borderRadius: 10,
              controller: _buttonController,
              successColor: Colors.green,
              valueColor: Colors.white,
              child: const Text(
                'Tambah Admin',
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tambahAdmin(BuildContext context) async {
    final loginController =
        Provider.of<LoginController>(context, listen: false);

    if (_validateEmail(_emailController.text) == null) {
      try {
        await loginController.tambahAdmin(_emailController.text);
        _showSuccessDialog(context, 'Admin berhasil ditambahkan');
      } catch (e) {
        _showErrorDialog(context, e.toString());
      } finally {
        _buttonController.reset();
      }
    } else {
      _showErrorDialog(context, 'Email tidak valid');
    }
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sukses'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
