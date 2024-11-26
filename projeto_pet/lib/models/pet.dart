class Pet {
  final String id;
  final String nome;
  final String raca;
  final String urlImagem;
  final String descricao;
  final String idade;

  Pet({
    required this.id,
    required this.nome,
    required this.raca,
    required this.urlImagem,
    required this.descricao,
    required this.idade,
  });

  // Construtor para criar um Pet a partir de um mapa (Firestore)
  factory Pet.fromFirestore(String id, Map<String, dynamic> json) {
    return Pet(
      id: id,
      nome: json['nome'],
      raca: json['raca'],
      urlImagem: json['urlImagem'],
      descricao: json['descricao'],
      idade: json['idade'],
    );
  }

  // Método para converter o Pet de volta para um mapa (para Firestore)
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'raca': raca,
      'urlImagem': urlImagem,
      'descricao': descricao,
      'idade': idade,
    };
  }
}
