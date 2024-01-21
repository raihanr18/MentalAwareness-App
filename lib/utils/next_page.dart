import 'package:flutter/material.dart';

void nextPage(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextPageReplace(context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}