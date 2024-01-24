import 'package:flutter/material.dart';

BoxDecoration roundedWidget({Color color = Colors.white, double radius = 25.0}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    ),
  );
}