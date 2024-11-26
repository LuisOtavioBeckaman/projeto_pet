class Abrigo {
  final String id;
  final String nome;
  final String contato;
  final String localizacao;
  final String descricao;
  final List<String> eventos;

  Abrigo({
    required this.id,
    required this.nome,
    required this.contato,
    required this.localizacao,
    required this.descricao,
    required this.eventos,
  });

  // Construtor para criar um Abrigo a partir de um mapa (JSON)
  factory Abrigo.fromJson(String id, Map<String, dynamic> json) {
    return Abrigo(
      id: id,
      nome: json['nome'],
      contato: json['contato'],
      localizacao: json['localizacao'],
      descricao: json['descricao'],
      eventos: List<String>.from(json['eventos'] ?? []),
    );
  }

  // Método para converter o Abrigo de volta para um mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'contato': contato,
      'localizacao': localizacao,
      'descricao': descricao,
      'eventos': eventos,
    };
  }
}
