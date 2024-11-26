import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Registra um novo usuário
  Future<String?> registerUser({
    required String nome,
    required String email,
    required String senha,
    required String cpf,
    required String telefone,
  }) async {
    try {
      // Cria o usuário no Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // ID único do usuário
      String userId = userCredential.user!.uid;

      // Salva os dados complementares no Firestore
      await _firestore.collection('users').doc(userId).set({
        'nome': nome,
        'email': email,
        'cpf': cpf,
        'telefone': telefone,
        'created_at': DateTime.now().toIso8601String(),
      });

      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Este e-mail já está em uso.';
      } else if (e.code == 'weak-password') {
        return 'A senha deve ter pelo menos 6 caracteres.';
      }
      return 'Erro ao registrar usuário: ${e.message}';
    } catch (e) {
      return 'Erro inesperado: $e';
    }
  }
}
