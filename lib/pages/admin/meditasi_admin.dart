import 'package:flutter/material.dart';

class MeditasiAdmin extends StatefulWidget {
  const MeditasiAdmin({super.key});

  @override
  State<MeditasiAdmin> createState() => _MeditasiAdminState();
}

class _MeditasiAdminState extends State<MeditasiAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditasi Admin'),
      ),
      body: const Center(
        child: Text('Meditasi Admin'),
      ),
    );
  }
}