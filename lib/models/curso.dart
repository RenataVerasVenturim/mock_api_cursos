class Curso {
  final String titulo;
  final int? vagasDisponiveis;

  Curso({required this.titulo, this.vagasDisponiveis});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      titulo: json['titulo'] ?? 'Sem título',
      vagasDisponiveis: json['vagas_disponiveis'],
    );
  }
}
