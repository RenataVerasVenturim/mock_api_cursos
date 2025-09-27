import 'package:flutter/material.dart';
import 'pages/cursos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cursos UFF',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CursosPage(),
    );
  }
}
