import 'package:flutter/material.dart';
import 'database/database_helper.dart'; // Certifique-se de importar o DatabaseHelper
import 'views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Certifique-se de inicializar os widgets
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
