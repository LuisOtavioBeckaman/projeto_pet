import 'package:flutter/material.dart';
import 'package:projeto_pet/controllers/pet_controller.dart';
import 'package:projeto_pet/models/pet.dart';

class DetalhePet extends StatelessWidget {
  final String petId;
  final PetController _petController = PetController(); // Inicialização não constante

  DetalhePet({required this.petId, super.key}); // Remover 'const'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do Pet'),
      ),
      body: FutureBuilder<Pet>(
        future: _petController.getPet(petId), // Usando o método getPet
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar detalhes do pet'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Pet não encontrado'));
          } else {
            Pet pet = snapshot.data!; // Usando a instância de Pet
            return SingleChildScrollView( // Adicionando rolagem
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(pet.urlImagem),
                    const SizedBox(height: 16),
                    Text(
                      pet.nome,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pet.raca,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pet.descricao,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
