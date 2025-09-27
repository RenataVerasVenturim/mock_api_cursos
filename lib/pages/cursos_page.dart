import 'package:flutter/material.dart';
import '../models/curso.dart';
import '../services/api_service.dart';

class CursosPage extends StatelessWidget {
  const CursosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cursos UFF')),
      body: FutureBuilder<List<Curso>>(
        future: ApiService.fetchCursos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum curso disponível'));
          } else {
            final cursos = snapshot.data!;
            return ListView.builder(
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                final curso = cursos[index];
                return ListTile(
                  title: Text(curso.titulo),
                  subtitle: Text('Vagas: ${curso.vagasDisponiveis ?? 'N/A'}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
