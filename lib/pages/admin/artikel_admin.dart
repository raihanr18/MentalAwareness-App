import 'package:flutter/material.dart';

class ArtikelAdmin extends StatefulWidget {
  const ArtikelAdmin({super.key});

  @override
  State<ArtikelAdmin> createState() => _ArtikelAdminState();
}

class _ArtikelAdminState extends State<ArtikelAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel Admin'),
      ),
      body: Center(
        child: Text('Artikel Admin'),
      ),
    );
  }
}