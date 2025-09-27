import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/curso.dart';

class ApiService {
  static const String baseUrl = 'https://github.com/RenataVerasVenturim/mock_api_cursos.git'; 

  static Future<List<Curso>> fetchCursos() async {
    final response = await http.get(Uri.parse('$baseUrl/api/cursos'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((curso) => Curso.fromJson(curso)).toList();
    } else {
      throw Exception('Falha ao carregar cursos');
    }
  }
}
