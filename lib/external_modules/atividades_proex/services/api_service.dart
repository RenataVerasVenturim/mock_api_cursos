import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/atividade.dart';

class ApiService {
  static const String baseUrl = 'https://raw.githubusercontent.com/RenataVerasVenturim/mock_api_cursos/refs/heads/main/lib/cursos.json'; 

  static Future<List<Atividade>> fetchAtividades() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);

      return jsonData
          .map((atividade) => Atividade.fromJson(atividade))
          .where((atividade) => atividade.vagasDisponiveis != null && atividade.linkInscricao != null)
          .toList();
    } else {
      throw Exception('Falha ao carregar atividades');
    }
  }
}





