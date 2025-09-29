import 'package:flutter/material.dart';
import 'external_modules/atividades_proex/ui/atividades_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividades PROEX',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AtividadesPage(),
    );
  }
}
