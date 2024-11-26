class Visita {
  final String id;
  final String petId;
  final String abrigoId;
  final DateTime dataVisita;
  final String nomeVisitante;

  Visita({
    required this.id,
    required this.petId,
    required this.abrigoId,
    required this.dataVisita,
    required this.nomeVisitante,
  });

  // Construtor para criar uma Visita a partir de um mapa (JSON)
  factory Visita.fromJson(String id, Map<String, dynamic> json) {
    return Visita(
      id: id, // Agora o ID é passado como argumento
      petId: json['petId'],
      abrigoId: json['abrigoId'],
      dataVisita: DateTime.parse(json['dataVisita']),
      nomeVisitante: json['nomeVisitante'],
    );
  }

  // Método para converter a Visita de volta para um mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'petId': petId,
      'abrigoId': abrigoId,
      'dataVisita': dataVisita.toIso8601String(),
      'nomeVisitante': nomeVisitante,
    };
  }
}
