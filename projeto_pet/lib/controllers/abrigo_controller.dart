import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:projeto_pet/models/abrigo.dart';

class AbrigoController {
  final CollectionReference _shelterCollection =
      FirebaseFirestore.instance.collection('abrigos');

  // Adiciona um novo abrigo
  Future<void> addAbrigo(Abrigo abrigo) async {
    try {
      await _shelterCollection.add(abrigo.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao adicionar abrigo: $e');
      }
    }
  }

  // Atualiza os dados de um abrigo existente
  Future<void> updateAbrigo(String id, Abrigo abrigo) async {
    try {
      await _shelterCollection.doc(id).update(abrigo.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar abrigo: $e');
      }
    }
  }

  // Deleta um abrigo
  Future<void> deleteAbrigo(String id) async {
    try {
      await _shelterCollection.doc(id).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao deletar abrigo: $e');
      }
    }
  }

  // Busca um abrigo pelo ID
  Future<Abrigo> getAbrigo(String id) async {
    try {
      DocumentSnapshot doc = await _shelterCollection.doc(id).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Abrigo.fromJson(doc.id, data); // Retorna um Abrigo a partir do Firestore
      } else {
        throw Exception('Abrigo não encontrado');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar abrigo: $e');
      }
      rethrow;
    }
  }

  // Obtém todos os abrigos em tempo real
  Stream<List<Abrigo>> getAbrigos() {
    return _shelterCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Abrigo.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
