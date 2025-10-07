import 'package:flutter/material.dart';
import 'external_modules/atividades_proex/ui/atividades_page.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Atividades PROEX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
  primarySwatch: Colors.lightBlue,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1D324E), //fundo
    foregroundColor: Colors.white, // título e ícones
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 20),
    ),
  ),
      home: AtividadesPage(),
    );
  }
}
