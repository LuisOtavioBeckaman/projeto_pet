import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:projeto_pet/models/visita.dart';

class VisitaController {
  final CollectionReference _visitaCollection =
      FirebaseFirestore.instance.collection('visitas');

  // Adiciona uma nova visita
  Future<void> addVisita(Visita visita) async {
    try {
      // Adiciona os dados da visita no Firestore
      await _visitaCollection.add(visita.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao adicionar visita: $e');
      }
    }
  }

  // Atualiza uma visita existente
  Future<void> updateVisita(String id, Visita visita) async {
    try {
      await _visitaCollection.doc(id).update(visita.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar visita: $e');
      }
    }
  }

  // Deleta uma visita
  Future<void> deleteVisita(String id) async {
    try {
      await _visitaCollection.doc(id).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao deletar visita: $e');
      }
    }
  }

  // Busca uma visita específica
  Future<Visita> getVisita(String id) async {
    try {
      DocumentSnapshot doc = await _visitaCollection.doc(id).get();
      if (doc.exists) {
        // Retorna a visita a partir dos dados do Firestore
        return Visita.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      } else {
        throw Exception('Visita não encontrada');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar visita: $e');
      }
      rethrow;
    }
  }

  // Obtém todas as visitas em tempo real
  Stream<List<Visita>> getVisitas() {
    return _visitaCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Visita.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
