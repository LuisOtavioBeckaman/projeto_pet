class UserModel {
  final String id;
  final String nome;
  final String email;
  final String cpf;
  final String telefone;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.cpf,
    required this.telefone,
  });

  // Converte os dados de Firestore para o modelo de usuário
  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      nome: data['nome'] ?? '',
      email: data['email'] ?? '',
      cpf: data['cpf'] ?? '',
      telefone: data['telefone'] ?? '',
    );
  }

  // Converte o modelo de usuário para um mapa
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'telefone': telefone,
    };
  }
}
