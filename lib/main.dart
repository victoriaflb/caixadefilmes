import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:caixadefilmes/views/homepage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {
   runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

