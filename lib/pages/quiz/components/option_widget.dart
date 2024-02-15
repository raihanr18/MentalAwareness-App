import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  const OptionWidget({super.key});

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 300,
      decoration: BoxDecoration(
          border:
              Border.all(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(50)),
          ),
          const Text(
            'Pilihan A',
            style: TextStyle(
                fontSize: 20, fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}