import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:projeto_pet/models/pet.dart';

class PetController {
  final CollectionReference _petCollection =
      FirebaseFirestore.instance.collection('pets');

  // Adiciona um novo pet
  Future<void> addPet(Pet pet) async {
    try {
      await _petCollection.add(pet.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao adicionar pet: $e');
      }
    }
  }

  // Atualiza os dados de um pet existente
  Future<void> updatePet(String id, Pet pet) async {
    try {
      await _petCollection.doc(id).update(pet.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar pet: $e');
      }
    }
  }

  // Deleta um pet
  Future<void> deletePet(String id) async {
    try {
      await _petCollection.doc(id).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao deletar pet: $e');
      }
    }
  }

  // Busca um pet pelo ID
  Future<Pet> getPet(String id) async {
    try {
      DocumentSnapshot doc = await _petCollection.doc(id).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Pet.fromFirestore(doc.id, data); // Retorna um Pet a partir do Firestore
      } else {
        throw Exception('Pet não encontrado');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar pet: $e');
      }
      rethrow;
    }
  }

  // Obtém todos os pets em tempo real
  Stream<List<Pet>> getPets() {
    return _petCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Pet.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
