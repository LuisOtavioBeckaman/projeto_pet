import 'package:flutter/material.dart';
import 'package:projeto_pet/controllers/pet_controller.dart';
import 'package:projeto_pet/models/pet.dart';
import 'package:projeto_pet/views/detalhe_pet.dart';

class CatalogoPet extends StatelessWidget {
  final PetController _petController = PetController();

  CatalogoPet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Animais'),
      ),
      body: StreamBuilder<List<Pet>>(
        stream: _petController.getPets(), // Stream de List<Pet>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar pets'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum pet disponível para adoção'));
          } else {
            List<Pet> pets = snapshot.data!; // Usando List<Pet>
            return ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return ListTile(
                  leading: Image.network(pet.urlImagem),
                  title: Text(pet.nome),
                  subtitle: Text(pet.raca),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhePet(petId: pet.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
